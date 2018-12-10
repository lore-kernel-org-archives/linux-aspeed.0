From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 10 Dec 2018 22:39:50 +0000
Subject: [PATCH] ARM: dts: aspeed: Add KCS support for LPC BMC
In-Reply-To: <20181210200753.3018124-2-vijaykhemka@fb.com>
References: <20181210200753.3018124-1-vijaykhemka@fb.com>
 <20181210200753.3018124-2-vijaykhemka@fb.com>
Message-ID: <6061E60A-78CD-4C4C-A35C-0AD90BFC4286@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Please ignore this patch as it is duplicate. It is included in list of 2 patches I have sent just before.

?On 12/10/18, 12:08 PM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:

    Added kcs device support for lpc BMC.
    
    Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    ---
     arch/arm/boot/dts/aspeed-g5.dtsi | 29 ++++++++++++++++++++++++++++-
     1 file changed, 28 insertions(+), 1 deletion(-)
    
    diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
    index d107459fc0f8..1bd48655bacb 100644
    --- a/arch/arm/boot/dts/aspeed-g5.dtsi
    +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
    @@ -330,8 +330,35 @@
     				ranges = <0x0 0x1e789000 0x1000>;
     
     				lpc_bmc: lpc-bmc at 0 {
    -					compatible = "aspeed,ast2500-lpc-bmc";
    +					compatible = "aspeed,ast2500-lpc-bmc, "simple-mfd", "syscon"";
     					reg = <0x0 0x80>;
    +					reg-io-width = <4>;
    +
    +					#address-cells = <1>;
    +					#size-cells = <1>;
    +					ranges = <0x0 0x0 0x80>;
    +
    +					kcs1: kcs1 at 0 {
    +						compatible = "aspeed,ast2500-kcs-bmc";
    +						reg = <0x0 0x80>;
    +						interrupts = <8>;
    +						kcs_chan = <1>;
    +						status = "disabled";
    +					};
    +					kcs2: kcs2 at 0 {
    +						compatible = "aspeed,ast2500-kcs-bmc";
    +						reg = <0x0 0x80>;
    +						interrupts = <8>;
    +						kcs_chan = <2>;
    +						status = "disabled";
    +					};
    +					kcs3: kcs3 at 0 {
    +						compatible = "aspeed,ast2500-kcs-bmc";
    +						reg = <0x0 0x80>;
    +						interrupts = <8>;
    +						kcs_chan = <3>;
    +						status = "disabled";
    +					};
     				};
     
     				lpc_host: lpc-host at 80 {
    -- 
    2.17.1
    
    

