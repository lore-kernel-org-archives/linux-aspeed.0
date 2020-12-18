From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 18 Dec 2020 14:23:33 +1030
Subject: [PATCH v6 1/6] mmc: core: Add helper for parsing clock phase
 properties
In-Reply-To: <20201218035338.1130849-1-andrew@aj.id.au>
References: <20201218035338.1130849-1-andrew@aj.id.au>
Message-ID: <20201218035338.1130849-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drivers for MMC hosts that accept phase corrections can take advantage
of the helper by embedding an instance of struct mmc_clk_phase_map in
their private data and invoking mmc_of_parse_clk_phase() to extract
phase parameters. It is the responsibility of the host driver to
translate and apply the extracted values to hardware as required.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/core/host.c  | 44 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h | 13 ++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 96b2ca1f1b06..74e853bb6948 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -163,6 +163,50 @@ static void mmc_retune_timer(struct timer_list *t)
 	mmc_retune_needed(host);
 }
 
+static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
+				      struct mmc_clk_phase *phase)
+{
+	int degrees[2] = {0};
+	int rc;
+
+	rc = device_property_read_u32_array(dev, prop, degrees, 2);
+	phase->valid = !rc;
+	if (phase->valid) {
+		phase->in_deg = degrees[0];
+		phase->out_deg = degrees[1];
+	}
+}
+
+void
+mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
+{
+	struct device *dev = host->parent;
+
+	mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
+				  &map->phase[MMC_TIMING_LEGACY]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
+				  &map->phase[MMC_TIMING_MMC_HS]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-sd-hs",
+				  &map->phase[MMC_TIMING_SD_HS]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr12",
+				  &map->phase[MMC_TIMING_UHS_SDR12]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr25",
+				  &map->phase[MMC_TIMING_UHS_SDR25]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr50",
+				  &map->phase[MMC_TIMING_UHS_SDR50]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr104",
+				  &map->phase[MMC_TIMING_UHS_SDR104]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-ddr50",
+				  &map->phase[MMC_TIMING_UHS_DDR50]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-ddr52",
+				  &map->phase[MMC_TIMING_MMC_DDR52]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs200",
+				  &map->phase[MMC_TIMING_MMC_HS200]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs400",
+				  &map->phase[MMC_TIMING_MMC_HS400]);
+}
+EXPORT_SYMBOL(mmc_of_parse_clk_phase);
+
 /**
  *	mmc_of_parse() - parse host's device-tree node
  *	@host: host whose node should be parsed.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 01bba36545c5..8cf686d98a68 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -79,6 +79,17 @@ struct mmc_ios {
 	bool enhanced_strobe;			/* hs400es selection */
 };
 
+struct mmc_clk_phase {
+	bool valid;
+	u16 in_deg;
+	u16 out_deg;
+};
+
+#define MMC_NUM_CLK_PHASES (MMC_TIMING_MMC_HS400 + 1)
+struct mmc_clk_phase_map {
+	struct mmc_clk_phase phase[MMC_NUM_CLK_PHASES];
+};
+
 struct mmc_host;
 
 struct mmc_host_ops {
@@ -490,6 +501,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *);
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
+void mmc_of_parse_clk_phase(struct mmc_host *host,
+			    struct mmc_clk_phase_map *map);
 int mmc_of_parse(struct mmc_host *host);
 int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
 
-- 
2.27.0

