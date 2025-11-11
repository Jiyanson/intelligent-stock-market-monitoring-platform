#!/usr/bin/env python3
"""
Policy Evaluation Script using BLEU and ROUGE-L Metrics

This script evaluates AI-generated security policies against reference policies
to measure quality, accuracy, and compliance alignment.

Metrics:
- BLEU (BiLingual Evaluation Understudy): Precision-based n-gram overlap
- ROUGE-L (Recall-Oriented Understudy): Longest Common Subsequence similarity
"""

import json
import os
import sys
import argparse
from pathlib import Path
from typing import Dict, List, Tuple
import nltk
from nltk.translate.bleu_score import sentence_bleu, SmoothingFunction
from rouge_score import rouge_scorer
import numpy as np

# Download required NLTK data
try:
    nltk.data.find('tokenizers/punkt')
except LookupError:
    print("Downloading NLTK punkt tokenizer...")
    nltk.download('punkt', quiet=True)


class PolicyEvaluator:
    """Evaluates AI-generated policies using BLEU and ROUGE-L metrics"""

    def __init__(self, reference_dir: str = "policy-templates", generated_dir: str = "ai-policies"):
        self.reference_dir = reference_dir
        self.generated_dir = generated_dir
        self.rouge_scorer = rouge_scorer.RougeScorer(['rougeL'], use_stemmer=True)
        self.smoothing = SmoothingFunction().method1

    def load_policy(self, filepath: str) -> Dict:
        """Load a policy JSON file"""
        try:
            with open(filepath, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            print(f"❌ Error: File not found: {filepath}")
            return {}
        except json.JSONDecodeError:
            print(f"❌ Error: Invalid JSON in {filepath}")
            return {}

    def extract_policy_text(self, policy: Dict) -> str:
        """Extract relevant text from policy for evaluation"""
        texts = []

        # Extract NIST CSF recommendations
        for rec in policy.get('nist_csf_recommendations', []):
            texts.append(rec.get('description', ''))
            texts.append(rec.get('implementation', ''))

        # Extract ISO 27001 controls
        for control in policy.get('iso27001_controls', []):
            texts.append(control.get('title', ''))
            texts.append(control.get('ai_recommendation', ''))

        # Extract remediation priorities
        for rem in policy.get('remediation_priorities', []):
            texts.append(rem.get('action', ''))
            texts.append(rem.get('reasoning', ''))

        # Extract raw LLM response if available
        if 'raw_llm_response' in policy:
            texts.append(policy['raw_llm_response'])

        return ' '.join(filter(None, texts))

    def calculate_bleu(self, reference: str, candidate: str) -> float:
        """Calculate BLEU score between reference and candidate texts"""
        # Tokenize
        reference_tokens = nltk.word_tokenize(reference.lower())
        candidate_tokens = nltk.word_tokenize(candidate.lower())

        # Calculate BLEU with smoothing
        score = sentence_bleu(
            [reference_tokens],
            candidate_tokens,
            smoothing_function=self.smoothing
        )

        return score

    def calculate_rouge_l(self, reference: str, candidate: str) -> Dict[str, float]:
        """Calculate ROUGE-L score between reference and candidate texts"""
        scores = self.rouge_scorer.score(reference, candidate)
        rouge_l = scores['rougeL']

        return {
            'precision': rouge_l.precision,
            'recall': rouge_l.recall,
            'f1': rouge_l.fmeasure
        }

    def evaluate_policy(self, generated_policy: Dict, reference_policy: Dict) -> Dict:
        """Evaluate a generated policy against a reference policy"""
        # Extract texts
        gen_text = self.extract_policy_text(generated_policy)
        ref_text = self.extract_policy_text(reference_policy)

        if not gen_text or not ref_text:
            return {
                'bleu': 0.0,
                'rouge_l': {'precision': 0.0, 'recall': 0.0, 'f1': 0.0},
                'error': 'Empty policy text'
            }

        # Calculate metrics
        bleu_score = self.calculate_bleu(ref_text, gen_text)
        rouge_l_scores = self.calculate_rouge_l(ref_text, gen_text)

        return {
            'bleu': bleu_score,
            'rouge_l': rouge_l_scores,
            'text_length_ratio': len(gen_text) / len(ref_text) if len(ref_text) > 0 else 0
        }

    def compare_models(self, models: List[str]) -> Dict:
        """Compare multiple LLM models' policy generation quality"""
        results = {}

        # Load reference policy
        ref_path = os.path.join(self.reference_dir, "nist_csf_reference.json")
        reference_policy = self.load_policy(ref_path)

        if not reference_policy:
            print(f"❌ Warning: No reference policy found at {ref_path}")
            print("   Creating a basic reference policy...")
            reference_policy = self.create_default_reference()

        for model in models:
            policy_path = os.path.join(self.generated_dir, f"{model}_generated_policy.json")

            if not os.path.exists(policy_path):
                print(f"⚠️  Skipping {model}: Policy file not found")
                continue

            generated_policy = self.load_policy(policy_path)

            if generated_policy:
                print(f"📊 Evaluating {model.upper()} policy...")
                evaluation = self.evaluate_policy(generated_policy, reference_policy)
                results[model] = evaluation

        return results

    def create_default_reference(self) -> Dict:
        """Create a default reference policy for evaluation"""
        return {
            "nist_csf_recommendations": [
                {
                    "function": "IDENTIFY",
                    "category": "ID.RA-5",
                    "description": "Threats, vulnerabilities, likelihoods, and impacts are used to determine risk",
                    "implementation": "Conduct regular vulnerability assessments and risk analysis"
                },
                {
                    "function": "PROTECT",
                    "category": "PR.IP-12",
                    "description": "A vulnerability management plan is developed and implemented",
                    "implementation": "Establish process for identifying, classifying, and remediating vulnerabilities"
                },
                {
                    "function": "DETECT",
                    "category": "DE.CM-8",
                    "description": "Vulnerability scans are performed",
                    "implementation": "Implement automated vulnerability scanning tools and processes"
                }
            ],
            "iso27001_controls": [
                {
                    "control": "A.8.8",
                    "title": "Management of technical vulnerabilities",
                    "ai_recommendation": "Implement systematic vulnerability management program"
                },
                {
                    "control": "A.12.6.1",
                    "title": "Management of technical vulnerabilities (legacy)",
                    "ai_recommendation": "Establish timely remediation procedures for identified vulnerabilities"
                }
            ],
            "remediation_priorities": [
                {
                    "priority": 1,
                    "action": "Remediate critical vulnerabilities immediately",
                    "reasoning": "Critical vulnerabilities pose immediate risk to system security"
                }
            ]
        }

    def generate_report(self, results: Dict, output_path: str = "evaluation-results"):
        """Generate evaluation report with metrics"""
        os.makedirs(output_path, exist_ok=True)

        # Prepare summary
        summary_lines = []
        summary_lines.append("# Policy Evaluation Results\n")
        summary_lines.append(f"**Evaluation Date**: {pd.Timestamp.now().strftime('%Y-%m-%d %H:%M:%S')}\n" if 'pd' in dir() else "")
        summary_lines.append("\n## Comparative Analysis\n")

        # Table header
        summary_lines.append("| Model | BLEU Score | ROUGE-L F1 | ROUGE-L Precision | ROUGE-L Recall |")
        summary_lines.append("|-------|------------|------------|-------------------|----------------|")

        # Results table
        for model, metrics in sorted(results.items()):
            bleu = metrics.get('bleu', 0.0)
            rouge_l = metrics.get('rouge_l', {})

            summary_lines.append(
                f"| **{model.upper()}** | {bleu:.4f} | {rouge_l.get('f1', 0.0):.4f} | "
                f"{rouge_l.get('precision', 0.0):.4f} | {rouge_l.get('recall', 0.0):.4f} |"
            )

        # Analysis
        summary_lines.append("\n## Interpretation\n")
        summary_lines.append("### BLEU Score")
        summary_lines.append("- Range: 0-1 (higher is better)")
        summary_lines.append("- Measures n-gram precision overlap with reference policy")
        summary_lines.append("- > 0.3: Good alignment with reference")
        summary_lines.append("- > 0.5: Excellent alignment\n")

        summary_lines.append("### ROUGE-L Score")
        summary_lines.append("- Range: 0-1 (higher is better)")
        summary_lines.append("- Measures longest common subsequence similarity")
        summary_lines.append("- F1 combines precision and recall")
        summary_lines.append("- > 0.4: Good semantic similarity\n")

        # Determine best model
        if results:
            best_model = max(results.items(), key=lambda x: x[1].get('bleu', 0))
            summary_lines.append(f"\n### Best Performing Model: **{best_model[0].upper()}**\n")
            summary_lines.append(f"- BLEU Score: {best_model[1].get('bleu', 0.0):.4f}")
            summary_lines.append(f"- ROUGE-L F1: {best_model[1].get('rouge_l', {}).get('f1', 0.0):.4f}\n")

        # Save summary
        summary_path = os.path.join(output_path, "summary.md")
        with open(summary_path, 'w') as f:
            f.write('\n'.join(summary_lines))

        # Save detailed JSON results
        detailed_path = os.path.join(output_path, "detailed_results.json")
        with open(detailed_path, 'w') as f:
            json.dump(results, f, indent=2)

        print(f"\n📄 Evaluation reports saved:")
        print(f"   - Summary: {summary_path}")
        print(f"   - Detailed: {detailed_path}")

        return summary_path, detailed_path


def main():
    """Main execution function"""
    parser = argparse.ArgumentParser(
        description="Evaluate AI-generated security policies using BLEU and ROUGE-L metrics"
    )
    parser.add_argument(
        "--models",
        nargs='+',
        default=["llama", "deepseek"],
        help="List of LLM models to evaluate (default: llama deepseek)"
    )
    parser.add_argument(
        "--generated-dir",
        type=str,
        default="ai-policies",
        help="Directory containing generated policies"
    )
    parser.add_argument(
        "--reference-dir",
        type=str,
        default="policy-templates",
        help="Directory containing reference policies"
    )
    parser.add_argument(
        "--output",
        type=str,
        default="evaluation-results",
        help="Directory to save evaluation results"
    )

    args = parser.parse_args()

    print("="*70)
    print("Policy Evaluation with BLEU and ROUGE-L Metrics")
    print("="*70)

    # Initialize evaluator
    evaluator = PolicyEvaluator(
        reference_dir=args.reference_dir,
        generated_dir=args.generated_dir
    )

    # Compare models
    print(f"\n🔍 Evaluating {len(args.models)} model(s): {', '.join(args.models)}")
    results = evaluator.compare_models(args.models)

    if not results:
        print("\n❌ No policies found to evaluate.")
        print("   Make sure to run real_llm_integration.py first to generate policies.")
        sys.exit(1)

    # Generate report
    print("\n📊 Generating evaluation report...")
    summary_path, detailed_path = evaluator.generate_report(results, args.output)

    # Print summary to console
    print("\n" + "="*70)
    print("EVALUATION SUMMARY")
    print("="*70)
    for model, metrics in sorted(results.items()):
        print(f"\n{model.upper()}:")
        print(f"  BLEU Score:        {metrics.get('bleu', 0.0):.4f}")
        print(f"  ROUGE-L Precision: {metrics.get('rouge_l', {}).get('precision', 0.0):.4f}")
        print(f"  ROUGE-L Recall:    {metrics.get('rouge_l', {}).get('recall', 0.0):.4f}")
        print(f"  ROUGE-L F1:        {metrics.get('rouge_l', {}).get('f1', 0.0):.4f}")

    print("\n" + "="*70)
    print("✅ Evaluation complete!")
    print("="*70 + "\n")


if __name__ == "__main__":
    main()
