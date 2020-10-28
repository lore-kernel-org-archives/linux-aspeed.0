From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Oct 2020 05:10:49 +0000
Subject: [PATCH 2/3] Arm: dts: aspeed-g6: Add sgpio node
In-Reply-To: <E0B8BD13-86F6-486E-95DF-1038D7F59A8B@aspeedtech.com>
References: <20201012033150.21056-1-billy_tsai@aspeedtech.com>
 <20201012033150.21056-3-billy_tsai@aspeedtech.com>
 <CACPK8XdYvSmwdAkBzAO3kC8_PYa3CtPkNb0VxcOhmb2UYz5zDA@mail.gmail.com>
 <E0B8BD13-86F6-486E-95DF-1038D7F59A8B@aspeedtech.com>
Message-ID: <CACPK8Xeg_LRGv1EEm7cdDWK2xST0mBP=iG7=43UE5qmEMMDsHQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2020 at 04:56, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> Hi Joel,
>
> Thanks for the review.
>
> On 2020/10/12, 12:35 PM, Joel Stanley wrote:
>
>     > On Mon, 12 Oct 2020 at 03:32, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>     > >
>     > > This patch is used to add sgpiom and sgpios nodes and add compatible
>     > > string for sgpiom.
>     >
>     > You also need to add sgpios documentation to the bindings docs.
>     >
>     > Whenever you add new device tree bindings to the kernel tree you
>     > should add documentation for them.
>     >
>     > When preparing patches for submission, use scripts/checkpatch.pl to
>     > check for common issues. It will warn you if you are adding strings
>     > that are not documented.
>     >
>     > Cheers,
>     >
>     > Joel
>     >
>    Because the driver of sgpios doesn't be implemented, so I don't know how to describe it at sgpio-aspeed.txt.
>    Can I just add  compatible string " aspeed,ast2600-sgpios " to the document for bypassing the warning of checkpatch?

Ignore the sgpios issue for now; we don't have a driver for it so
there's no need to add strings. Drop that part from your dts patch.

>     > >
>     > >  - compatible : Should be one of
>     > > -  "aspeed,ast2400-sgpio", "aspeed,ast2500-sgpio"
>     > > +  "aspeed,ast2400-sgpio", "aspeed,ast2500-sgpio", "aspeed,ast2600-sgpiom"
>     >
>     > I think we should add sgpiom strings for the ast2500 (and ast2400?)
>     > too, as this is how they should have been named in the first place:
>     >
>    If I change the document whether I also need to send the patch for sgpio driver and g5/g4.dtsi?

For the sgpiom? We already have a driver for that.

As I said above, make this about fixing the sgpio master and put aside
the sgpio slave issue for now.

Cheers,

Joel

>     > >  - compatible : Should be one of
>     > >    "aspeed,ast2400-sgpio", "aspeed,ast2500-sgpio"
>     > >   "aspeed,ast2400-sgpiom", "aspeed,ast2500-sgpiom", "aspeed,ast2600-sgpiom"
