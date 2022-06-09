From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu,  9 Jun 2022 13:40:41 +0200
Subject: [PATCH v2 42/48] ARM: dts: aspeed: align gpio-key node names with dtschema
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20220609114047.380793-3-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 30 ++++++------
 .../boot/dts/aspeed-bmc-bytedance-g220a.dts   | 48 +++++++++----------
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts  |  8 ++--
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  | 12 ++---
 .../boot/dts/aspeed-bmc-inspur-fp5280g2.dts   | 22 ++++-----
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts   | 23 ++++-----
 arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts   | 20 ++++----
 arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts   |  2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |  2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |  2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts    | 30 ++++++------
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   | 12 ++---
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts   |  4 +-
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   | 16 +++----
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |  4 +-
 15 files changed, 118 insertions(+), 117 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 1b2e7ad37566..82a6f14a45f0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -100,91 +100,91 @@ identify {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		shutdown_ack {
+		event-shutdown-ack {
 			label = "SHUTDOWN_ACK";
 			gpios = <&gpio ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(G, 2)>;
 		};
 
-		reboot_ack {
+		event-reboot-ack {
 			label = "REBOOT_ACK";
 			gpios = <&gpio ASPEED_GPIO(J, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 3)>;
 		};
 
-		S0_overtemp {
+		event-s0-overtemp {
 			label = "S0_OVERTEMP";
 			gpios = <&gpio ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(G, 3)>;
 		};
 
-		S0_hightemp {
+		event-s0-hightemp {
 			label = "S0_HIGHTEMP";
 			gpios = <&gpio ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 0)>;
 		};
 
-		S0_cpu_fault {
+		event-s0-cpu-fault {
 			label = "S0_CPU_FAULT";
 			gpios = <&gpio ASPEED_GPIO(J, 1) GPIO_ACTIVE_HIGH>;
 			linux,code = <ASPEED_GPIO(J, 1)>;
 		};
 
-		S0_scp_auth_fail {
+		event-s0-scp-auth-fail {
 			label = "S0_SCP_AUTH_FAIL";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
 		};
 
-		S1_scp_auth_fail {
+		event-s1-scp-auth-fail {
 			label = "S1_SCP_AUTH_FAIL";
 			gpios = <&gpio ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 5)>;
 		};
 
-		S1_overtemp {
+		event-s1-overtemp {
 			label = "S1_OVERTEMP";
 			gpios = <&gpio ASPEED_GPIO(Z, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 6)>;
 		};
 
-		S1_hightemp {
+		event-s1-hightemp {
 			label = "S1_HIGHTEMP";
 			gpios = <&gpio ASPEED_GPIO(AB, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(AB, 0)>;
 		};
 
-		S1_cpu_fault {
+		event-s1-cpu-fault {
 			label = "S1_CPU_FAULT";
 			gpios = <&gpio ASPEED_GPIO(Z, 1) GPIO_ACTIVE_HIGH>;
 			linux,code = <ASPEED_GPIO(Z, 1)>;
 		};
 
-		id_button {
+		event-id {
 			label = "ID_BUTTON";
 			gpios = <&gpio ASPEED_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Q, 5)>;
 		};
 
-		psu1_vin_good {
+		event-psu1-vin-good {
 			label = "PSU1_VIN_GOOD";
 			gpios = <&gpio ASPEED_GPIO(H, 4) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 4)>;
 		};
 
-		psu2_vin_good {
+		event-psu2-vin-good {
 			label = "PSU2_VIN_GOOD";
 			gpios = <&gpio ASPEED_GPIO(H, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 5)>;
 		};
 
-		psu1_present {
+		event-psu1-present {
 			label = "PSU1_PRESENT";
 			gpios = <&gpio ASPEED_GPIO(I, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(I, 0)>;
 		};
 
-		psu2_present {
+		event-psu2-present {
 			label = "PSU2_PRESENT";
 			gpios = <&gpio ASPEED_GPIO(I, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(I, 1)>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
index 0d1fb5ccfd36..f75cad41ae6f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
@@ -100,7 +100,7 @@ bmc_alive {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		burn-in-signal {
+		event-burn-in-signal {
 			label = "burn-in";
 			gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(R, 5)>;
@@ -111,139 +111,139 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		rear-riser1-presence {
+		event-rear-riser1-presence {
 			label = "rear-riser1-presence";
 			gpios = <&pca0 1 GPIO_ACTIVE_LOW>;
 			linux,code = <1>;
 		};
 
-		alrt-pvddq-cpu0 {
+		event-alrt-pvddq-cpu0 {
 			label = "alrt-pvddq-cpu0";
 			gpios = <&pca0 8 GPIO_ACTIVE_LOW>;
 			linux,code = <2>;
 		};
 
-		rear-riser0-presence {
+		event-rear-riser0-presence {
 			label = "rear-riser0-presence";
 			gpios = <&pca0 9 GPIO_ACTIVE_LOW>;
 			linux,code = <3>;
 		};
 
-		fault-pvddq-cpu0 {
+		event-fault-pvddq-cpu0 {
 			label = "fault-pvddq-cpu0";
 			gpios = <&pca0 10 GPIO_ACTIVE_LOW>;
 			linux,code = <4>;
 		};
 
-		alrt-pvddq-cpu1 {
+		event-alrt-pvddq-cpu1 {
 			label = "alrt-pvddq-cpu1";
 			gpios = <&pca0 11 GPIO_ACTIVE_LOW>;
 			linux,code = <5>;
 		};
 
-		fault-pvddq-cpu1 {
+		event-fault-pvddq-cpu1 {
 			label = "alrt-pvddq-cpu1";
 			gpios = <&pca0 12 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fault-pvccin-cpu1 {
+		event-fault-pvccin-cpu1 {
 			label = "fault-pvccin-cpuq";
 			gpios = <&pca0 13 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
 		};
 
-		bmc-rom0-wp {
+		event-bmc-rom0-wp {
 			label = "bmc-rom0-wp";
 			gpios = <&pca1 0 GPIO_ACTIVE_LOW>;
 			linux,code = <8>;
 		};
 
-		bmc-rom1-wp {
+		event-bmc-rom1-wp {
 			label = "bmc-rom1-wp";
 			gpios = <&pca1 1 GPIO_ACTIVE_LOW>;
 			linux,code = <9>;
 		};
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca1 2 GPIO_ACTIVE_LOW>;
 			linux,code = <10>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca1 3 GPIO_ACTIVE_LOW>;
 			linux,code = <11>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca1 4 GPIO_ACTIVE_LOW>;
 			linux,code = <12>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca1 5 GPIO_ACTIVE_LOW>;
 			linux,code = <13>;
 		};
 
-		fan4-presence {
+		event-fan4-presence {
 			label = "fan4-presence";
 			gpios = <&pca1 6 GPIO_ACTIVE_LOW>;
 			linux,code = <14>;
 		};
 
-		fan5-presence {
+		event-fan5-presence {
 			label = "fan5-presence";
 			gpios = <&pca1 7 GPIO_ACTIVE_LOW>;
 			linux,code = <15>;
 		};
 
-		front-bp1-presence {
+		event-front-bp1-presence {
 			label = "front-bp1-presence";
 			gpios = <&pca1 8 GPIO_ACTIVE_LOW>;
 			linux,code = <16>;
 		};
 
-		rear-bp-presence {
+		event-rear-bp-presence {
 			label = "rear-bp-presence";
 			gpios = <&pca1 9 GPIO_ACTIVE_LOW>;
 			linux,code = <17>;
 		};
 
-		fault-pvccin-cpu0 {
+		event-fault-pvccin-cpu0 {
 			label = "fault-pvccin-cpu0";
 			gpios = <&pca1 10 GPIO_ACTIVE_LOW>;
 			linux,code = <18>;
 		};
 
-		alrt-p1v05-pvcc {
+		event-alrt-p1v05-pvcc {
 			label = "alrt-p1v05-pvcc1";
 			gpios = <&pca1 11 GPIO_ACTIVE_LOW>;
 			linux,code = <19>;
 		};
 
-		fault-p1v05-pvccio {
+		event-fault-p1v05-pvccio {
 			label = "alrt-p1v05-pvcc1";
 			gpios = <&pca1 12 GPIO_ACTIVE_LOW>;
 			linux,code = <20>;
 		};
 
-		alrt-p1v8-pvccio {
+		event-alrt-p1v8-pvccio {
 			label = "alrt-p1v8-pvccio";
 			gpios = <&pca1 13 GPIO_ACTIVE_LOW>;
 			linux,code = <21>;
 		};
 
-		fault-p1v8-pvccio {
+		event-fault-p1v8-pvccio {
 			label = "fault-p1v8-pvccio";
 			gpios = <&pca1 14 GPIO_ACTIVE_LOW>;
 			linux,code = <22>;
 		};
 
-		front-bp0-presence {
+		event-front-bp0-presence {
 			label = "front-bp0-presence";
 			gpios = <&pca1 15 GPIO_ACTIVE_LOW>;
 			linux,code = <23>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 382da7934eaa..afad8d732cc3 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -193,25 +193,25 @@ gpio-keys-polled {
 		#size-cells = <0>;
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca0 15 GPIO_ACTIVE_LOW>;
 			linux,code = <15>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
 			linux,code = <14>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca0 13 GPIO_ACTIVE_LOW>;
 			linux,code = <13>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca0 12 GPIO_ACTIVE_LOW>;
 			linux,code = <12>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 7213434695bf..fc8222ea2dd0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -183,37 +183,37 @@ gpio-keys-polled {
 		#size-cells = <0>;
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca0 8 GPIO_ACTIVE_LOW>;
 			linux,code = <8>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca0 9 GPIO_ACTIVE_LOW>;
 			linux,code = <9>;
 		};
 
-		fan4-presence {
+		event-fan4-presence {
 			label = "fan4-presence";
 			gpios = <&pca0 10 GPIO_ACTIVE_LOW>;
 			linux,code = <10>;
 		};
 
-		fan5-presence {
+		event-fan5-presence {
 			label = "fan5-presence";
 			gpios = <&pca0 11 GPIO_ACTIVE_LOW>;
 			linux,code = <11>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
index 60a39ea10ab1..208b0f094ed9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
@@ -73,19 +73,19 @@ fsi: gpio-fsi {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(B, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(B, 3)>;
 		};
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio ASPEED_GPIO(F, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 0)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 1)>;
@@ -97,49 +97,49 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca1 0 GPIO_ACTIVE_LOW>;
 			linux,code = <1>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca1 1 GPIO_ACTIVE_LOW>;
 			linux,code = <2>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca1 2 GPIO_ACTIVE_LOW>;
 			linux,code = <3>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca1 3 GPIO_ACTIVE_LOW>;
 			linux,code = <4>;
 		};
 
-		fan4-presence {
+		event-fan4-presence {
 			label = "fan4-presence";
 			gpios = <&pca1 4 GPIO_ACTIVE_LOW>;
 			linux,code = <5>;
 		};
 
-		fan5-presence {
+		event-fan5-presence {
 			label = "fan5-presence";
 			gpios = <&pca1 5 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fan6-presence {
+		event-fan6-presence {
 			label = "fan6-presence";
 			gpios = <&pca1 6 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
 		};
 
-		fan7-presence {
+		event-fan7-presence {
 			label = "fan7-presence";
 			gpios = <&pca1 7 GPIO_ACTIVE_LOW>;
 			linux,code = <8>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index a52a289cee85..48776fb663fb 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -92,30 +92,31 @@ video_engine_memory: jpegbuffer {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		air-water {
+		event-air-water {
 			label = "air-water";
 			gpios = <&gpio ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 6)>;
 		};
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
 		};
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 2)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 0)>;
 		};
-		id-button {
+
+		button-id {
 			label = "id-button";
 			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 1)>;
@@ -126,37 +127,37 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca9552 9 GPIO_ACTIVE_LOW>;
 			linux,code = <9>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca9552 10 GPIO_ACTIVE_LOW>;
 			linux,code = <10>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca9552 11 GPIO_ACTIVE_LOW>;
 			linux,code = <11>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca9552 12 GPIO_ACTIVE_LOW>;
 			linux,code = <12>;
 		};
 
-		fan4-presence {
+		event-fan4-presence {
 			label = "fan4-presence";
 			gpios = <&pca9552 13 GPIO_ACTIVE_LOW>;
 			linux,code = <13>;
 		};
 
-		fan5-presence {
+		event-fan5-presence {
 			label = "fan5-presence";
 			gpios = <&pca9552 14 GPIO_ACTIVE_LOW>;
 			linux,code = <14>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
index 7d38d121ec6d..31ff19ef87a0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
@@ -46,31 +46,31 @@ video_engine_memory: jpegbuffer {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		air-water {
+		event-air-water {
 			label = "air-water";
 			gpios = <&gpio ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 6)>;
 		};
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
 		};
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 2)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 0)>;
 		};
 
-		id-button {
+		button-id {
 			label = "id-button";
 			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 1)>;
@@ -81,31 +81,31 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca9552 9 GPIO_ACTIVE_LOW>;
 			linux,code = <9>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca9552 10 GPIO_ACTIVE_LOW>;
 			linux,code = <10>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca9552 11 GPIO_ACTIVE_LOW>;
 			linux,code = <11>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca9552 12 GPIO_ACTIVE_LOW>;
 			linux,code = <12>;
 		};
 
-		fan4-presence {
+		event-fan4-presence {
 			label = "fan4-presence";
 			gpios = <&pca9552 13 GPIO_ACTIVE_LOW>;
 			linux,code = <13>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
index 3d4bdad27c2d..ac0d666ca10e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
@@ -96,7 +96,7 @@ fsi: gpio-fsi {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index cd660c1ff3f5..45631b47a7b3 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -73,7 +73,7 @@ fsi: gpio-fsi {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(P, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(P, 5)>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 084f54866f38..893e621ecab1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -87,7 +87,7 @@ fsi: gpio-fsi {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
index 4816486c0c9e..bbf864f84d37 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -38,37 +38,37 @@ gfx_memory: framebuffer {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		air-water {
+		event-air-water {
 			label = "air-water";
 			gpios = <&gpio ASPEED_GPIO(B, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(B, 5)>;
 		};
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
 		};
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio ASPEED_GPIO(R, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(R, 7)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio ASPEED_GPIO(N, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(N, 0)>;
 		};
 
-		oppanel-presence {
+		event-oppanel-presence {
 			label = "oppanel-presence";
 			gpios = <&gpio ASPEED_GPIO(A, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(A, 7)>;
 		};
 
-		opencapi-riser-presence {
+		event-opencapi-riser-presence {
 			label = "opencapi-riser-presence";
 			gpios = <&gpio ASPEED_GPIO(I, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(I, 0)>;
@@ -84,55 +84,55 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		scm0-presence {
+		event-scm0-presence {
 			label = "scm0-presence";
 			gpios = <&pca9552 6 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		scm1-presence {
+		event-scm1-presence {
 			label = "scm1-presence";
 			gpios = <&pca9552 7 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
 		};
 
-		cpu0vrm-presence {
+		event-cpu0vrm-presence {
 			label = "cpu0vrm-presence";
 			gpios = <&pca9552 12 GPIO_ACTIVE_LOW>;
 			linux,code = <12>;
 		};
 
-		cpu1vrm-presence {
+		event-cpu1vrm-presence {
 			label = "cpu1vrm-presence";
 			gpios = <&pca9552 13 GPIO_ACTIVE_LOW>;
 			linux,code = <13>;
 		};
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca0 5 GPIO_ACTIVE_LOW>;
 			linux,code = <5>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca0 8 GPIO_ACTIVE_LOW>;
 			linux,code = <8>;
 		};
 
-		fanboost-presence {
+		event-fanboost-presence {
 			label = "fanboost-presence";
 			gpios = <&pca0 9 GPIO_ACTIVE_LOW>;
 			linux,code = <9>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 72b7a6639ed9..6f6a35fe2caf 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -50,13 +50,13 @@ vga_memory: region at bf000000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 3)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio0 ASPEED_GPIO(E, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(E, 5)>;
@@ -69,25 +69,25 @@ gpio-keys-polled {
 		#size-cells = <0>;
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca0 4 GPIO_ACTIVE_LOW>;
 			linux,code = <4>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca0 5 GPIO_ACTIVE_LOW>;
 			linux,code = <5>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
index 328ef472c479..8a7fb55ab489 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -63,13 +63,13 @@ alarm_yel {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		button_checkstop {
+		event-checkstop {
 			label = "checkstop";
 			linux,code = <74>;
 			gpios = <&gpio ASPEED_GPIO(P, 5) GPIO_ACTIVE_LOW>;
 		};
 
-		button_identify {
+		event-identify {
 			label = "identify";
 			linux,code = <152>;
 			gpios = <&gpio ASPEED_GPIO(O, 7) GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 230f3584bcab..a20a532fc280 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -51,25 +51,25 @@ video_engine_memory: jpegbuffer {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		air-water {
+		event-air-water {
 			label = "air-water";
 			gpios = <&gpio ASPEED_GPIO(B, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(B, 5)>;
 		};
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
 		};
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(P, 7)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio ASPEED_GPIO(N, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(N, 0)>;
@@ -85,25 +85,25 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca0 4 GPIO_ACTIVE_LOW>;
 			linux,code = <4>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca0 5 GPIO_ACTIVE_LOW>;
 			linux,code = <5>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 7ae4ea0d2931..0cb7b20ff3ab 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -58,13 +58,13 @@ onewire3 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 7)>;
 		};
 
-		pcie-e2b-present{
+		event-pcie-e2b-present{
 			label = "pcie-e2b-present";
 			gpios = <&gpio ASPEED_GPIO(E, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(E, 7)>;
-- 
2.34.1

