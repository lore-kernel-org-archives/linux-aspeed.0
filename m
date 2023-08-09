From: Joel Stanley <joel@jms.id.au>
Date: Wed, 9 Aug 2023 08:15:51 +0000
Subject: [PATCH v7 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite 4 BMC
In-Reply-To: <CACPK8XfwcsnrrF9YJ7y-sLRx1OWfrvhNi2G3Tbhww_dXfSOUXw@mail.gmail.com>
References: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
 <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com> <CACPK8XfFWC-wxCt4DwNRNctXap5qiZUz-utcbpnp0vj=Z46=9Q@mail.gmail.com>
 <CACPK8XfwcsnrrF9YJ7y-sLRx1OWfrvhNi2G3Tbhww_dXfSOUXw@mail.gmail.com>
Message-ID: <CACPK8XeUbaMhST73UUT7BZzb2ajVU-M7yfQfEkmX2J=pzk=Tiw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 9 Aug 2023 at 08:12, Joel Stanley <joel@jms.id.au> wrote:
>
> On Wed, 9 Aug 2023 at 08:05, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Tue, 8 Aug 2023 at 08:43, Delphine CC Chiu
> > <Delphine_CC_Chiu@wiwynn.com> wrote:
> > >
> > > Add linux device tree entry related to
> > > Yosemite 4 specific devices connected to BMC SoC.
>
> There were also some of these annoying warnings. Please try to fix
> them up in your next version:
>
> ../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:460.4-14:
> Warning (reg_format):
> /ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 71/i2c at 0:reg: property has
> invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)@@ -450,6 +450,9 @@ eeprom at 51 {

This silenced most of them:

        i2c-mux at 71 {
                compatible = "nxp,pca9846";
+               #address-cells = <1>;
+               #size-cells = <0>;
+
                idle-state = <0>;
                i2c-mux-idle-disconnect;
                reg = <0x71>;
@@ -557,6 +560,9 @@ gpio at 61 {

        i2c-mux at 73 {
                compatible = "nxp,pca9544";
+               #address-cells = <1>;
+               #size-cells = <0>;
+
                idle-state = <0>;
                i2c-mux-idle-disconnect;
                reg = <0x73>;

And then this fixed the remaining one:

@@ -423,7 +423,7 @@ power-sensor at 42 {
                reg = <0x42>;
        };

-       power-sensor at 41 {
+       power-sensor at 43 {
                compatible = "ti,ina230";
                reg = <0x43>;
        };


Please fold in these changes in your next version.
