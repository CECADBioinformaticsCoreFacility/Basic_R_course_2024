# R Programming Course for Biologists

Welcome to our R Programming Course specifically designed for biologists, including master and PhD students. This course aims to equip participants with basic R programming skills and introduce them to statistical analysis techniques applicable in molecular biology.

## Course Overview

This two-day intensive course covers everything from basic programming in R to advanced statistical analyses relevant to molecular biology. Participants will learn through a mix of lectures, hands-on exercises, and interactive discussions. By the end of the course, you will be able to perform data manipulation, create visualizations, and conduct statistical analyses using R.

### Prerequisites

Participants are expected to have the following installed on their computers before the course begins:
- R
- RStudio
- Git
- Installing the following R-libraries:
  - [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)
  - [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html)
  - [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html)
  - [gprofiler2](https://cran.r-project.org/web/packages/gprofiler2/index.html)
  - [clusterProfiler](https://bioconductor.org/packages/release/bioc/html/clusterProfiler.html)
  - [imager](https://cran.r-project.org/web/packages/imager/index.html)
  - [magick](https://cran.r-project.org/web/packages/magick/index.html)
  - [tibble](https://cran.r-project.org/web/packages/tibble/index.html)
  - [MASS](https://cran.r-project.org/web/packages/MASS/index.html)
  - [tidyr](https://cran.r-project.org/web/packages/tidyr/index.html)
  - [stringr](https://stringr.tidyverse.org/)
  - **Additionally, please install the following libraries as they were added afterwards:** [UPDATE]
    - [car](https://cran.r-project.org/web/packages/car/index.html)
    - [Rcmdr](https://cran.r-project.org/web/packages/Rcmdr/index.html)
    - [ggpubr](https://cran.r-project.org/web/packages/ggpubr/index.html)
    - [openxlsx](https://cran.r-project.org/web/packages/openxlsx/index.html)
  - **To install these additional packages, use the following R command:**
    ```r
    install.packages(c("car", "Rcmdr", "ggpubr", "openxlsx"))
    ```
Installation guides:
- [R Installation Guide](https://cran.r-project.org/)
- [RStudio Installation Guide](https://www.rstudio.com/products/rstudio/download/)
- [Git Installation Guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

Participants are also expected to have a GitHub account.

## Important Installation Notice

It's crucial for all participants to install R, RStudio, and Git prior to the start of the course. These tools are essential for participating in the course exercises and for following along with the instruction.

### Pre-Course Zoom Session

Considering the importance of a smooth start to our course, we're planning to host a Zoom pre-course session. This session is intended to help with the installation process, address any issues you might encounter, and answer any questions. Stay tuned for the schedule and details.

### Trouble Installing?

If you encounter any issues during the installation process, please:
- Refer to the FAQs and troubleshooting guides provided on the respective software download pages.
- Post your issue on the GitHub issues section of this repository. Please provide as much detail as possible about the problem you're experiencing.
- Contact us directly via email, and we'll do our best to assist you.

### Practice Before the Course

We strongly recommend that you try to familiarize yourself with R and RStudio by following some basic tutorials or trying out simple exercises. This will help you hit the ground running when the course starts.


## Course Content

### Day 1: Introduction to R and Basic Programming Concepts

#### Session 1: Basic Programming in R
- Introduction to R and RStudio
- Basic R Syntax and Operations

#### Session 2: Data Entry and Data Management [[Exercise](https://cecadbioinformaticscorefacility.github.io/Basic_R_course_CGA/docs/ReferenceExercise#session-1-2)]
- Data Import and Export
- Data Manipulation (base R and `dplyr`)

#### Session 3: Creating Graphics [[Exercise](https://cecadbioinformaticscorefacility.github.io/Basic_R_course_CGA/docs/ReferenceExercise#session-3)]
- Introduction to Base Graphics in R (base R and `ggplot2`)

#### Session 4: Descriptive Statistics
- Frequency/Cross Tables, Mean, Standard Deviation, Correlation

### Day 2: Statistical Analysis in R

#### Session 1: Inferential Statistics - Part 1
- Fisher’s Exact Test, T-tests.

#### Session 2: Inferential Statistics - Part 2
- Multiple Linear Regression, ANOVA

#### Session 3: Molecular Biology Applications
- PCA and Hierarchical Clustering

#### Session 4: Real-World Data Application
- Case Study: Gene Expression Data Analysis

## Getting Started

To get started with the course materials, clone this repository using Git:

****

https://github.com/CECADBioinformaticsCoreFacility/R_course_CGA

Navigate into the cloned directory to access all course materials, datasets, and exercises.

## Resources

For further learning and exploration of R, we recommend the following resources:
- [R for Data Science](https://r4ds.had.co.nz/)
- [Bioconductor for Genomic Data Analysis](https://www.bioconductor.org/)
- [Advanced R](https://adv-r.hadley.nz/)

## Contributing

We welcome contributions to improve the course materials. Please feel free to fork the repository, make changes, and submit a pull request.

## Contact

For any queries regarding the course, please reach out to us at cecad-bifacility-course@uni-koeln.de

## Acknowledgements

We would like to thank all contributors and participants for making this course possible. Special thanks to the R community for the comprehensive resources and support.
