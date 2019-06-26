From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 26 Jun 2019 16:44:30 +0930
Subject: [PATCH 8/8] pinctrl: aspeed: Add implementation-related documentation
In-Reply-To: <20190626071430.28556-1-andrew@aj.id.au>
References: <20190626071430.28556-1-andrew@aj.id.au>
Message-ID: <20190626071430.28556-9-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ASPEED pinctrl driver implementations make heavy use of macros to
minimise tedium of implementation and maximise the chance that the
compiler will catch errors in defining signal and pin configurations.
While the goal of minimising errors is achieved, it is at the cost of
the complexity of the macros.

Document examples of the expanded form of pin declarations to
demonstrate the operation of the macros.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinmux-aspeed.h | 204 ++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index a036ce8f1571..329d54d48667 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -18,7 +18,8 @@
  * priority level are frequently not the same (i.e. cannot just flip a bit to
  * change from a high to low priority signal), or even in the same register.
  * Further, not all signals can be unmuxed, as some expressions depend on
- * values in the hardware strapping register (which is treated as read-only).
+ * values in the hardware strapping register (which may be treated as
+ * read-only).
  *
  * SoC Multi-function Pin Expression Examples
  * ------------------------------------------
@@ -172,9 +173,9 @@
  * * A signal expression is the smallest set of signal descriptors whose
  *   comparisons must evaluate 'true' for a signal to be enabled on a pin.
  *
- * * A function's signal is active on a pin if evaluating all signal
- *   descriptors in the pin's signal expression for the function yields a 'true'
- *   result
+ * * A signal participating in a function is active on a pin if evaluating all
+ *   signal descriptors in the pin's signal expression for the function yields
+ *   a 'true' result
  *
  * * A signal at a given priority on a given pin is active if any of the
  *   functions in which the signal participates are active, and no higher
@@ -221,6 +222,201 @@
  * well as pins) required for the group's configuration will already be in use,
  * likely in a way that's inconsistent with the requirements of the failed
  * group.
+ *
+ * Implementation
+ * --------------
+ *
+ * Beyond the documentation below the various structures and helper macros that
+ * allow the implementation to hang together are defined. The macros are fairly
+ * dense, so below we walk through some raw examples of the configuration
+ * tables in an effort to clarify the concepts.
+ *
+ * The complexity of configuring the mux combined with the scale of the pins
+ * and functions was a concern, so the table design along with the macro jungle
+ * is an attempt to address it. The rough principles of the approach are:
+ *
+ * 1. Use a data-driven solution rather than embedding state into code
+ * 2. Minimise editing to the specifics of the given mux configuration
+ * 3. Detect as many errors as possible at compile time
+ *
+ * Addressing point 3 leads to naming of symbols in terms of the four
+ * properties associated with a given mux configuration: The pin, the signal,
+ * the group and the function. In this way copy/paste errors cause duplicate
+ * symbols to be defined, which prevents successful compilation. Failing to
+ * properly parent the tables leads to unused symbol warnings, and use of
+ * designated initialisers and additional warnings ensures that there are
+ * no override errors in the pin, group and function arrays.
+ *
+ * Addressing point 2 drives the development of the macro jungle, as it
+ * centralises the definition noise at the cost of taking some time to
+ * understand.
+ *
+ * Here's a complete, concrete "pre-processed" example of the table structures
+ * used to describe the D6 ball from the examples above:
+ *
+ * ```
+ * static const struct aspeed_sig_desc sig_descs_MAC1LINK_MAC1LINK[] = {
+ *     {
+ *         .ip = ASPEED_IP_SCU,
+ *         .reg = 0x80,
+ *         .mask = BIT(0),
+ *         .enable = 1,
+ *         .disable = 0
+ *     },
+ * };
+ *
+ * static const struct aspeed_sig_expr sig_expr_MAC1LINK_MAC1LINK = {
+ *     .signal = "MAC1LINK",
+ *     .function = "MAC1LINK",
+ *     .ndescs = ARRAY_SIZE(sig_descs_MAC1LINK_MAC1LINK),
+ *     .descs = &(sig_descs_MAC1LINK_MAC1LINK)[0],
+ * };
+ *
+ * static const struct aspeed_sig_expr *sig_exprs_MAC1LINK_MAC1LINK[] = {
+ *     &sig_expr_MAC1LINK_MAC1LINK,
+ *     NULL,
+ * };
+ *
+ * static const struct aspeed_sig_desc sig_descs_GPIOA0_GPIOA0[] = { };
+ *
+ * static const struct aspeed_sig_expr sig_expr_GPIOA0_GPIOA0 = {
+ *     .signal = "GPIOA0",
+ *     .function = "GPIOA0",
+ *     .ndescs = ARRAY_SIZE(sig_descs_GPIOA0_GPIOA0),
+ *     .descs = &(sig_descs_GPIOA0_GPIOA0)[0],
+ * };
+ *
+ * static const struct aspeed_sig_expr *sig_exprs_GPIOA0_GPIOA0[] = {
+ *     &sig_expr_GPIOA0_GPIOA0,
+ *     NULL
+ * };
+ *
+ * static const struct aspeed_sig_expr **pin_exprs_0[] = {
+ *     sig_exprs_MAC1LINK_MAC1LINK,
+ *     sig_exprs_GPIOA0_GPIOA0,
+ *     NULL
+ * };
+ *
+ * static const struct aspeed_pin_desc pin_0 = { "0", (&pin_exprs_0[0]) };
+ * static const int group_pins_MAC1LINK[] = { 0 };
+ * static const char *func_groups_MAC1LINK[] = { "MAC1LINK" };
+ *
+ * static struct pinctrl_pin_desc aspeed_g4_pins[] = {
+ *     [0] = { .number = 0, .name = "D6", .drv_data = &pin_0 },
+ * };
+ *
+ * static const struct aspeed_pin_group aspeed_g4_groups[] = {
+ *     {
+ *         .name = "MAC1LINK",
+ *         .pins = &(group_pins_MAC1LINK)[0],
+ *         .npins = ARRAY_SIZE(group_pins_MAC1LINK),
+ *     },
+ * };
+ *
+ * static const struct aspeed_pin_function aspeed_g4_functions[] = {
+ *     {
+ *         .name = "MAC1LINK",
+ *         .groups = &func_groups_MAC1LINK[0],
+ *         .ngroups = ARRAY_SIZE(func_groups_MAC1LINK),
+ *     },
+ * };
+ * ```
+ *
+ * At the end of the day much of the above code is compressed into the
+ * following two lines:
+ *
+ * ```
+ * #define D6 0
+ * SSSF_PIN_DECL(D6, GPIOA0, MAC1LINK, SIG_DESC_SET(SCU80, 0));
+ * ```
+ *
+ * The two examples below show just the differences from the example above.
+ *
+ * Ball E18 demonstrates a function, EXTRST, that requires multiple descriptors
+ * be set for it to be muxed:
+ *
+ * ```
+ * static const struct aspeed_sig_desc sig_descs_EXTRST_EXTRST[] = {
+ *     {
+ *         .ip = ASPEED_IP_SCU,
+ *         .reg = 0x3C,
+ *         .mask = BIT(3),
+ *         .enable = 1,
+ *         .disable = 0
+ *     },
+ *     {
+ *         .ip = ASPEED_IP_SCU,
+ *         .reg = 0x80,
+ *         .mask = BIT(15),
+ *         .enable = 1,
+ *         .disable = 0
+ *     },
+ *     {
+ *         .ip = ASPEED_IP_SCU,
+ *         .reg = 0x90,
+ *         .mask = BIT(31),
+ *         .enable = 0,
+ *         .disable = 1
+ *     },
+ * };
+ *
+ * static const struct aspeed_sig_expr sig_expr_EXTRST_EXTRST = {
+ *     .signal = "EXTRST",
+ *     .function = "EXTRST",
+ *     .ndescs = ARRAY_SIZE(sig_descs_EXTRST_EXTRST),
+ *     .descs = &(sig_descs_EXTRST_EXTRST)[0],
+ * };
+ * ...
+ * ```
+ *
+ * For ball E19, we have multiple functions enabling a single signal, LPCRST#.
+ * The data structures look like:
+ *
+ * static const struct aspeed_sig_desc sig_descs_LPCRST_LPCRST[] = {
+ *     {
+ *         .ip = ASPEED_IP_SCU,
+ *         .reg = 0x80,
+ *         .mask = BIT(12),
+ *         .enable = 1,
+ *         .disable = 0
+ *     },
+ * };
+ *
+ * static const struct aspeed_sig_expr sig_expr_LPCRST_LPCRST = {
+ *     .signal = "LPCRST",
+ *     .function = "LPCRST",
+ *     .ndescs = ARRAY_SIZE(sig_descs_LPCRST_LPCRST),
+ *     .descs = &(sig_descs_LPCRST_LPCRST)[0],
+ * };
+ *
+ * static const struct aspeed_sig_desc sig_descs_LPCRST_LPCRSTS[] = {
+ *     {
+ *         .ip = ASPEED_IP_SCU,
+ *         .reg = 0x70,
+ *         .mask = BIT(14),
+ *         .enable = 1,
+ *         .disable = 0
+ *     },
+ * };
+ *
+ * static const struct aspeed_sig_expr sig_expr_LPCRST_LPCRSTS = {
+ *     .signal = "LPCRST",
+ *     .function = "LPCRSTS",
+ *     .ndescs = ARRAY_SIZE(sig_descs_LPCRST_LPCRSTS),
+ *     .descs = &(sig_descs_LPCRST_LPCRSTS)[0],
+ * };
+ *
+ * static const struct aspeed_sig_expr *sig_exprs_LPCRST_LPCRST[] = {
+ *     &sig_expr_LPCRST_LPCRST,
+ *     &sig_expr_LPCRST_LPCRSTS,
+ *     NULL,
+ * };
+ * ...
+ * ```
+ *
+ * Both expressions listed in the sig_exprs_LPCRST_LPCRST array need to be set
+ * to disabled for the associated GPIO to be muxed.
+ *
  */
 
 #define ASPEED_IP_SCU		0
-- 
2.20.1

