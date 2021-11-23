From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 23 Nov 2021 15:49:22 -0800
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,get}()
 helpers
In-Reply-To: <637a4183861a1f2cdab52b7652bfa7ed33fbcdd2.camel@sipsolutions.net>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
 <20211122171739.03848154@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMuHMdWAAGrQUZN18cnDTDUUhuPNTZTFkRMe2Sbf+s7CedPSxA@mail.gmail.com>
 <637a4183861a1f2cdab52b7652bfa7ed33fbcdd2.camel@sipsolutions.net>
Message-ID: <20211123154922.600fd3b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 23 Nov 2021 17:24:15 +0100 Johannes Berg wrote:
> > (*_replace_bits() seems to be useful, though)  
> 
> Indeed.
> 
> Also as I said in my other mail, the le32/be32/... variants are
> tremendously useful, and they fundamentally cannot be expressed with the
> FIELD_GET() or field_get() macros. IMHO this is a clear advantage to the

Can you elaborate?

> typed versions, and if you ask me we should get rid of the FIELD_GETand
> FIELD_PREP entirely - difficult now, but at least let's not propagate
> that?

I don't see why.
