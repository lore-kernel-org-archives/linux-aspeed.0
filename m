From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Mar 2021 19:15:34 -0700
Subject: [PATCH v4 1/4] dt-bindings: i2c: aspeed: add transfer mode support
In-Reply-To: <f6732348-d6c8-f49b-6123-afe542bb1f8c@linux.intel.com>
References: <20210224191720.7724-1-jae.hyun.yoo@linux.intel.com>
 <20210224191720.7724-2-jae.hyun.yoo@linux.intel.com>
 <20210306203011.GA1152769@robh.at.kernel.org>
 <f6732348-d6c8-f49b-6123-afe542bb1f8c@linux.intel.com>
Message-ID: <CAL_Jsq+H2wCyTKhGcQvgiuyMtGW0hytQgw=948q0JGLSLOo9KA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 9, 2021 at 10:02 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> Hi Rob,
>
> On 3/6/2021 12:30 PM, Rob Herring wrote:
> > On Wed, Feb 24, 2021 at 11:17:17AM -0800, Jae Hyun Yoo wrote:
> >> Append bindings to support transfer mode.
> >>
> >> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> >> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >> ---
> >> Changes since v3:
> >> - None
> >>
> >> Changes since v2:
> >> - Moved SRAM resources back to default dtsi and added mode selection
> >>    property.
> >>
> >> Changes since v1:
> >> - Removed buffer reg settings from default device tree and added the settings
> >>    into here to show the predefined buffer range per each bus.
> >>
> >>   .../devicetree/bindings/i2c/i2c-aspeed.txt    | 37 +++++++++++++++----
> >>   1 file changed, 30 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> >> index b47f6ccb196a..242343177324 100644
> >> --- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> >> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> >> @@ -17,6 +17,20 @@ Optional Properties:
> >>   - bus-frequency    : frequency of the bus clock in Hz defaults to 100 kHz when not
> >>                specified
> >>   - multi-master     : states that there is another master active on this bus.
> >> +- aspeed,i2c-xfer-mode      : should be "byte", "buf" or "dma" to select transfer
> >> +                      mode defaults to "byte" mode when not specified.
> >> +
> >> +                      I2C DMA mode on AST2500 has these restrictions:
> >> +                        - If one of these controllers is enabled
> >> +                            * UHCI host controller
> >> +                            * MCTP controller
> >> +                          I2C has to use buffer mode or byte mode instead
> >> +                          since these controllers run only in DMA mode and
> >> +                          I2C is sharing the same DMA H/W with them.
> >> +                        - If one of these controllers uses DMA mode, I2C
> >> +                          can't use DMA mode
> >> +                            * SD/eMMC
> >> +                            * Port80 snoop
> >
> > How does one decide between byte or buf mode?
>
> If a given system makes just one byte r/w transactions most of the time
> then byte mode will be a right setting. Otherwise, buf mode is more
> efficient because it doesn't generate a bunch of interrupts on every
> byte handling.

Then why doesn't the driver do byte transactions when it gets small
1-4? byte transactions and buffer transactions when it gets larger
sized transactions.

Rob
