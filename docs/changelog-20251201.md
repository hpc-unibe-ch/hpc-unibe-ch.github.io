# UBELIX Changelog  
**Date:** 01‑12‑2025  

---

## Billing System  

This maintenance introduces a **new billing system** for UBELIX.  
If you do **not** belong to a project (which can be requested via the **Technik‑Verantwortliche** of your institute) you will only have access to the free‑tier resources. Billing starts **1 January 2025**.

> **Important:** If you have used UBELIX before, you will need to update your existing job‑submission scripts.

---

## Free‑Tier Resources  

**TL;DR:** `#SBATCH --account=gratis`

* Access is provided through the **`gratis`** account.  
* The default QOS on the `gratis` account is now **`job_gratis`**.  
* Available QOS for `gratis`:

  - `job_gratis`  
  - `job_debug`  
  - `job_cpu_preemptable`  
  - `job_gpu_preemptable`

* All other QOS have been removed from the `gratis` account.  

> **Tip:** Use the **`paygo`** or an **`invest`** account for more resource‑intensive workloads.

---

## Pay‑As‑You‑Go Resources  

**TL;DR:**  

```bash
#SBATCH --account=paygo
#SBATCH --wckey=<wckey>
```

* Available through the **`paygo`** account.  
* Visible only if you have been added to a **cost‑enabled research project** by a project owner.  
* Jobs submitted to `paygo` receive a notification with:
  * Projected cost for the current job.  
  * Cumulative projected cost for the current month.  

* Project owners set a **cost ceiling**. When the ceiling is reached, further jobs are **rejected**.  

* **Invoicing:**  
  * No invoice will be issued for December 2025.  
  * The first invoice (for January 2026 usage) will be sent in early **February 2026**.  

* More information: [here](https://intern.unibe.ch/dienstleistungen/informatik/dienstleistungen_der_informatikdienste/dienstleistungen___ressourcen/high_performance_computing___hpc___grid/index_ger.html)

---

## Investor Resources  

**TL;DR:**  

```bash
#SBATCH --account=invest
#SBATCH --qos=<investor-qos>
```

* Access is provided through the **`invest`** account.  

### CPU Investors  

* Jobs can be submitted to either  
  * `cpu-invest` **or**  
  * the partition `icpu-<investor>`  

  Both end up on the investor’s resources.

* **Note:** `icpu-` partitions are **hidden by default** in `sinfo` to keep the output manageable.  
  * To view them explicitly:  

    ```bash
    sinfo -p icpu-<investor>
    ```

---

## Teaching Resources  

**TL;DR:**  

```bash
#SBATCH --account=teaching
#SBATCH --reservation=<reservation>
```

* Free resources for teaching are available through the **`teaching`** account.  
* A **valid reservation** is required.  
* Reservations for courses must be requested **at least two weeks** in advance.

---

## Pre‑emptable Tier (`job_cpu_preemptable`)  

* An umbrella partition **`cpu-invest`** has been created for all `icpu-invest` partitions and the `epyc2` nodes.  
* This partition supports the new **pre‑emptable QOS** `job_cpu_preemptable`, which allows the usage of idle resources **for free** with the caveat that jobs may be cancelled (pre‑empted) by investor or pay‑go jobs.  

* Details: [here](https://hpc-unibe-ch.github.io/costs/freetier/#f3-preemptable-tier)

---

## Slurm Command Changes  

* The following commands/options are **no longer supported** on UBELIX:

  - `sbatch / srun --overcommit`  
  - `sbatch / srun --oversubscribe`  
  - `sbatch / srun --exclusive`

* Using `sbatch / srun --mem` **now requires** the `--nodes` option as well.  

* Resource‑request changes via `scontrol update` are no longer supported.

---

## Miscellaneous (Varia)

* Started infrastructure upgrades on the UBELIX core network to increase overall bandwidth.  
* System packages updated to the newest versions, including security patches.  
* **User software modules** were left unchanged.  
* Open OnDemand upgraded to the latest version.

---

## Known Issues  

1. **Open OnDemand forms** – a known bug causes inconsistent limits on resources.  
2. No **user‑friendly technical documentation** on pricing is available yet; it will be released soon.  
3. A **cost‑checking tool** (e.g., `squota`) is not yet implemented; this feature is upcoming.  

---  

*For any questions or further assistance, please contact the UBELIX support team.*
