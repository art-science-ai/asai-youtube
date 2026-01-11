# How spam detection taught us better tech support

**Source:** [Google Cloud Blog](https://cloud.google.com/blog/topics/developers-practitioners/how-spam-detection-taught-us-better-tech-support)
**Published:** November 13, 2021
**Authors:** Nicholaus Jackson (Business Analyst), Max Saltonstall (Developer Relations Engineer, Google)

---

## Overview

Information Technology teams need effective ways to track problems and understand how they change over time. Google's Techstop support team discovered that traditional problem management frameworks like ITIL 4 fail when products, services, and issues constantly shift. Instead of a fixed service catalog, they borrowed techniques from Gmail's spam detection to create an adaptive system for understanding IT support issues.

## The Problem: Fixed Taxonomies Don't Scale

### The Newspaper Delivery Analogy

Imagine managing a newspaper delivery team where routes change daily. Traditional IT support frameworks assume a fixed, well-defined catalog of services, but at Google:

- Products and services constantly evolve
- New problem types emerge daily
- Users experience novel issues specific to remote work
- Context shifts continuously

### COVID-19 Catalyst

The pandemic exposed critical gaps:
- Work-from-home model created entirely new neighborhoods of problems
- Products like Google Meet saw exponential growth and scaling issues
- A "good enough" taxonomy couldn't capture emerging patterns quickly enough
- New issues were hidden by a catalog that couldn't update fast enough

## The Solution: Borrowing from Spam Detection

### The Connection

Gmail's spam filtering handles over 1 billion accounts by detecting new spam campaigns quickly through unsupervised pattern detection. The problem shapes were similar:

- **Spam emails** = slightly varied messages with noise, misspellings
- **Support tickets** = similar issues with slight differences in spelling and word choice
- **Both domains** = need to detect ephemeral patterns in rapidly changing data

### Density Clustering Approach

Rather than rigid centroid-based algorithms like k-means, Google used **density-based clustering**:

- Better suited for large, heterogeneous datasets
- Can detect clusters of drastically different sizes
- Flexible enough to identify small-but-significant perturbations
- Can distinguish from large-but-stable patterns

**Implementation:** ClustOn (in-house), though open-source alternatives like [DBSCAN](https://en.wikipedia.org/wiki/DBSCAN) via [scikit-learn](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.DBSCAN.html) work similarly.

## The Support Insights Pipeline

The ML pipeline automatically distills summary data from support interactions through seven steps:

![Support Insights Pipeline](01-support-insights-pipeline.png)

### Step-by-Step Process

1. **Extracted**
   - Uses [BigQuery API](https://cloud.google.com/bigquery) to store and extract support data
   - Handles 1M+ IT support tickets

2. **Processed**
   - Part-of-speech tagging
   - PII redaction
   - [TF-IDF transformations](https://www.tensorflow.org/tfx/transform/api_docs/python/tft/tfidf)

3. **Clustered**
   - [Centroid-based clustering](https://cloud.google.com/bigquery-ml/docs/kmeans-tutorial) in timed batches
   - Persistent snapshots maintain cluster IDs
   - Track cluster behavior over time

4. **Scored**
   - [Poisson Regression](https://scikit-learn.org/stable/auto_examples/linear_model/plot_poisson_regression_non_normal_loss.html)
   - Models long-term and short-term cluster behavior
   - Calculates deviation to detect anomalies

5. **Operationalized**
   - Anomalous trends trigger [IssueTracker API](https://developers.google.com/issue-tracker) bugs
   - Operations teams pick up for deep dive analysis

6. **Resampled**
   - Statistical methods estimate customer user journey (CUJ) proportions within trends

7. **Categorized/Mapped**
   - Operations teams map trends to user journey segments

## Key Benefits

✅ **Dynamic taxonomy** - Buckets emerge naturally rather than being predefined
✅ **Real-time insights** - Identify trending issues as they happen
✅ **Scalable** - Handles volume comparable to Gmail's spam filtering
✅ **Granular** - Produces insights that would require dedicated manual teams
✅ **Flexible** - Adapts to constantly changing product landscape

## Getting Started

To implement a similar pipeline:

1. Load data into [BigQuery](https://cloud.google.com/bigquery)
2. Use [BigQuery ML](https://cloud.google.com/bigquery-ml/docs/introduction) to cluster support data
3. Apply density-based clustering techniques
4. Monitor anomalies using Poisson regression

## Related Resources

- [BigQuery ML Clustering Tutorial](https://cloud.google.com/bigquery-ml/docs/kmeans-tutorial)
- [Google ML Clustering Algorithms](https://developers.google.com/machine-learning/clustering/clustering-algorithms)
- [scikit-learn DBSCAN](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.DBSCAN.html)
- [TensorFlow Transform TF-IDF](https://www.tensorflow.org/tfx/transform/api_docs/python/tft/tfidf)
