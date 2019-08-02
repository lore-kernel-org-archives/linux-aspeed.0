From: Joel Stanley <joel@jms.id.au>
Date: Fri, 2 Aug 2019 06:31:22 +0000
Subject: [PATCH] dt-bindings: Add pxe1610 as a trivial device
In-Reply-To: <F7BAC53E-925E-4FA4-815D-ACB82DF8D240@fb.com>
References: <20190723002052.2878847-1-vijaykhemka@fb.com>
 <CAL_Jsq+uAjK6+xzkyOhcH96tZuqv7i6Nz5_nhUQkZ2adt2gutA@mail.gmail.com>
 <CAL_Jsq+Kw0TFW_v54Y2QHcChqpNDYhFyCSO5Cj-be9yLSCq-Pw@mail.gmail.com>
 <F7BAC53E-925E-4FA4-815D-ACB82DF8D240@fb.com>
Message-ID: <CACPK8XehEoakQxvQhC1cU5tvZaVbLOARtZ4xc6dD8sx9WDiPuA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add pxe1610 as a trivial device



On Tue, 23 Jul 2019 at 17:14, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> ?On 7/23/19, 7:53 AM, "Rob Herring" <robh+dt@kernel.org> wrote:
>
>     On Tue, Jul 23, 2019 at 8:50 AM Rob Herring <robh+dt@kernel.org> wrote:
>     >
>     > On Mon, Jul 22, 2019 at 6:46 PM Vijay Khemka <vijaykhemka@fb.com> wrote:
>     > >
>     > > The pxe1610 is a voltage regulator from Infineon. It also supports
>     > > other VRs pxe1110 and pxm1310 from Infineon.
>
>     What happened to the other compatibles? S/w doesn't need to know the
>     differences?
> As far as driver is concerned, it doesn't need to know differences.

You have these three IDs in the driver:

 pxm1310
 pxm1310
 pxe1610

So all three could be listed in the documentation?

Rob, is this what you wanted Vijay to do?
