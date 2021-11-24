From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 24 Nov 2021 15:07:47 +0100
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,get}()
 helpers
In-Reply-To: <20211124055935.416dc472@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
 <20211122171739.03848154@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMuHMdWAAGrQUZN18cnDTDUUhuPNTZTFkRMe2Sbf+s7CedPSxA@mail.gmail.com>
 <637a4183861a1f2cdab52b7652bfa7ed33fbcdd2.camel@sipsolutions.net>
 <20211123154922.600fd3b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <05d4673a0343bfd83824d307e9cf8bf92e3814a6.camel@sipsolutions.net>
 <20211124055935.416dc472@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <eea90adf2d51326f6d0bf0b97834063752a35c3f.camel@sipsolutions.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-11-24 at 05:59 -0800, Jakub Kicinski wrote:
> 
> FWIW I never found the be/le versions useful. Most of the time the data
> comes from bus accessors which swap or is unaligned so you have to do
> be/le_get_unaligned, which swaps. Plus if you access/set multiple
> fields you'd swap them one by one which seems wasteful.

Oh, we use them all the time in wifi!

I'm not sure I'm too concerned about wasteful - actually in wifi most of
the time it's little endian to start with, which matches the CPU for all
practical uses of wifi (**), and often we just access one field or so.
And anyway if we extract more than a single bit we need to swap anyway,
and I hope if it's just a single bit the compiler will optimize since
the one side is a constant? But whatever ...

(**) I had a fight with big-endian ARM a few years ago just to get wifi
tested on big-endian ...


> Right now it seems the uppercase macros are more prevalent.
> 

Not in my world ;-)

$ git grep FIELD_GET -- ... | wc -l
20
$ git grep le32_get_bits -- ... | wc -l
44
$ git grep le16_get_bits -- ... | wc -l
12
$ git grep u8_get_bits -- ... | wc -l
17

:-)

johannes
