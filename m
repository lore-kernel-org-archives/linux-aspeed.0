From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 04 May 2020 20:34:02 +0930
Subject: [PATCH v5] ARM: DTS: Aspeed: Add YADRO Nicole BMC
In-Reply-To: <CACPK8XcP3V=8fAUfNvRFqPU9G38dGR43Kpp=Uxm=P_AjrMnzBQ@mail.gmail.com>
References: <20200424135303.20952-1-a.filippov@yadro.com>
 <CACPK8XcP3V=8fAUfNvRFqPU9G38dGR43Kpp=Uxm=P_AjrMnzBQ@mail.gmail.com>
Message-ID: <c1de0c90-d486-4855-bb26-0f3cc416b05d@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 27 Apr 2020, at 20:41, Joel Stanley wrote:
> On Fri, 24 Apr 2020 at 13:53, Alexander Filippov <a.filippov@yadro.com> wrote:
> >
> > Nicole is an OpenPower machine with an Aspeed 2500 BMC SoC manufactured
> > by YADRO.
> >
> > Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> 
> This looks good to me.
> 
> Andrew, do you have any comments before I merge?

Not other than muxing all the ADC lines to enable just one seems a bit strange,
but Alexander mentioned previously that the rest were simply grounded so it's
not going to cause any problems in practice.

Andrew
