From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Nov 2021 11:29:08 -0500
Subject: [PATCH -next v2 5/6] dt-bindings: ipmi: aspeed,kcs-bmc: add
 'clocks' as a required property
In-Reply-To: <8db279c9-4c76-91a5-3617-a17effb2d103@linux.intel.com>
References: <20211102203717.96794-1-jae.hyun.yoo@intel.com>
 <20211102203717.96794-6-jae.hyun.yoo@intel.com>
 <1635902437.654631.3880388.nullmailer@robh.at.kernel.org>
 <8db279c9-4c76-91a5-3617-a17effb2d103@linux.intel.com>
Message-ID: <CAL_Jsq+SwCqFycKz4+agRsB3qr4Rbfra55Q6tNbMH2bNtoX+hA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 3, 2021 at 11:08 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> Hi Rob,
>
> On 11/2/2021 6:20 PM, Rob Herring wrote:
> > On Tue, 02 Nov 2021 13:37:16 -0700, jae.hyun.yoo at intel.com wrote:
> >> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> >>
> >> Add 'clocks' as a required property.
> >>
> >> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> >> ---
> >> v1 -> v2:
> >> Changes sinve v1:
> >>   - Added 'clocks' property into kcs-bmc bindings using
> >>     'aspeed,ast2400-kcs-bmc.yaml' because it's not merged into
> >>     'aspeed-lpc.yaml' yet. The bindings merging could be done using a
> >>     separate patch later.
> >>
> >>   .../devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml   | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> >
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> >
> > Full log is available here: https://patchwork.ozlabs.org/patch/1549943
> >
> >
> > kcs at 114: 'clocks' is a required property
> >       arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dt.yaml
> >       arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dt.yaml
> >       arch/arm/boot/dts/aspeed-bmc-inspur-nf5280m6.dt.yaml
> >
> > kcs at 24: 'clocks' is a required property
> >       arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dt.yaml
> >
> > kcs at 28: 'clocks' is a required property
> >       arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dt.yaml
> >       arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dt.yaml
> >       arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dt.yaml
> >
> > kcs at 2c: 'clocks' is a required property
> >       arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dt.yaml
> >       arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dt.yaml
> >       arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dt.yaml
> >       arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dt.yaml
> >       arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dt.yaml
> >       arch/arm/boot/dts/aspeed-bmc-inspur-nf5280m6.dt.yaml
> >
>
> #4/6 in this patch adds 'clocks' into aspeed-g5.dtsi and aspeed-g6.dtsi
> as a default property and all above dts files include the dtsi file so
> these warning shouldn't be seen. Is it a result after applying all
> changes in this series or just after cherry picking #5/6 patch only?

Only patch 5 is applied.

> I tested 'dtbs_check' before submitting this series I tested it again
> and got the same good result like below.
>
> Aren't the above warnings false positive? Or did I miss something?

What you missed is this is an ABI. You cannot make something required
that was not required before. If the driver follows the schema and
makes 'clocks' required, then old DTBs with a new kernel will break.

It's possible that 'clocks' was always required or that it never
worked without clocks, then this change is okay. Looking at this
patch, I have no way to know that. The commit message has to explain
that. A commit message needs to answer WHY are you making the change.
You don't really need WHAT the change is as anyone can read the diff.

Rob
