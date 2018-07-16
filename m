From: Rob Herring <robh@kernel.org>
Date: Mon, 16 Jul 2018 08:13:10 -0600
Subject: [PATCH 1/2] dt-bindings: fsi: Add optional chip-id to CFAMs
In-Reply-To: <c37eeb656151831123ec53bfc4e3c6caf718a060.camel@kernel.crashing.org>
References: <20180622043756.21158-1-benh@kernel.crashing.org>
 <20180703193017.GA23230@rob-hp-laptop>
 <23be30ebb2c661ef304c78a85cff591c515ba65b.camel@kernel.crashing.org>
 <CAL_JsqKZunLyRJQJgQrcBvv2s=HEd=E2ZG1ZgkgwTQkzJ88mcA@mail.gmail.com>
 <a6331cdbababea893bcde5f8ca9529dd89dafd67.camel@kernel.crashing.org>
 <c37eeb656151831123ec53bfc4e3c6caf718a060.camel@kernel.crashing.org>
Message-ID: <CAL_JsqJ6rEZzj+CJok1feGEFcM2DUxiYXig=h4hpJgyAOc4X5g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 11, 2018 at 8:07 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Fri, 2018-07-06 at 11:48 +1000, Benjamin Herrenschmidt wrote:
> > > We've generally standardized around "label" for things like slots,
> > > ports, connectors, etc. that need to be physically identified.
> >
> > Yes, label would be an option too, probably a better one that aliases.
> >
> > > "slot-names" it seems hasn't gotten used for FDT. Since there aren't
> > > DT's published for OF based systems nor any documentation, newbies
> > > like me (that only have 8 years of DT experience) don't have any
> > > insight into how things used to be done.
> >
> > In a pretty much ad-hoc way :-) In this case, though, chip-id is a
> > simple solution and works well (and I have the code already written and
> > tested :-)
>
> I want to try to get that stuff upstream. Do you still object to the
> chip-id's after our discussion ? The labels aren't that great really...

No.

Acked-by: Rob Herring <robh@kernel.org>
