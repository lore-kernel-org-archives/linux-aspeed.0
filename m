From: Joel Stanley <joel@jms.id.au>
Date: Wed, 31 Mar 2021 07:43:40 +0000
Subject: [PATCH 3/3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
In-Reply-To: <CACPK8XcwMYgc9R24KuGa0hqKQAxawDScHp1+y62aeEvcpvPiSw@mail.gmail.com>
References: <20210330002338.335-1-zev@bewilderbeest.net>
 <20210330002338.335-4-zev@bewilderbeest.net>
 <CACPK8XcwMYgc9R24KuGa0hqKQAxawDScHp1+y62aeEvcpvPiSw@mail.gmail.com>
Message-ID: <CACPK8XfU_az1WpOFjtVbEbqO46sv4eWbjSGwbzua4niQZ3pUQw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 31 Mar 2021 at 07:41, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 30 Mar 2021 at 00:25, Zev Weiss <zev@bewilderbeest.net> wrote:
> >
> > This is a relatively low-cost AST2500-based Xeon E-2100/E-2200 series
> > mini-ITX board that we hope can provide a decent platform for OpenBMC
> > development.
> >
> > This initial device-tree provides the necessary configuration for
> > basic BMC functionality such as host power control, serial console and
> > KVM support, and POST code snooping.
> >
> > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

> > +&vuart {
> > +       status = "okay";
> > +       aspeed,sirq-active-high;
>
> We don't have support for this yet, but I'll leave it in and you will
> need to send a follow up if the property changes.

Oh, I missed that this was part of your series to add support for that
property. Please keep the device tree out of the series when you
re-send the vuart patches. They go through different trees, so it's
easier if you send them separately in this case.
