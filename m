From: Jordan Chang <jordan.chang@ufispace.com>
Date: Mon, 13 Feb 2023 15:21:17 +0800
Subject: [PATCH v4 1/1] ARM: dts: aspeed: Add device tree for Ufispace
 NCPLite BMC
In-Reply-To: <12424bbd-cd3c-4d96-a7d8-1c83241b845f@app.fastmail.com>
References: <20230210103829.74470-1-jordan.chang@ufispace.com>
 <20230210103829.74470-2-jordan.chang@ufispace.com> <12424bbd-cd3c-4d96-a7d8-1c83241b845f@app.fastmail.com>
Message-ID: <CAJ3czeQSEv48M=_DWHs1-b7OxLccY1xe-VfNYRq9JUv_fHt3WQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

Thank you for taking time to review.

On Mon, Feb 13, 2023 at 9:56 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > +
> > +     temperature-sensor at 4f {
> > +             cpmpatible = "national,lm75";
>
> s/cpmp/comp/
Will revise the typo.

Best regards,
Jordan Chang
