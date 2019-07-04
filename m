From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 04 Jul 2019 10:28:45 +1000
Subject: [PATCH v2 0/8] pinctrl: aspeed: Preparation for AST2600
In-Reply-To: <CACRpkdaxiFR3ezt4FzhRxpqc4DYYjsbBeysPUaaQH+_QgYjudw@mail.gmail.com>
References: <20190628023838.15426-1-andrew@aj.id.au>
 <CACRpkdaxiFR3ezt4FzhRxpqc4DYYjsbBeysPUaaQH+_QgYjudw@mail.gmail.com>
Message-ID: <022b6528-7ab3-449f-807d-d711b6d2db51@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 3 Jul 2019, at 18:40, Linus Walleij wrote:
> Hi Andrew,
> 
> On Fri, Jun 28, 2019 at 4:39 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Hello!
> >
> > The ASPEED AST2600 is in the pipeline, and we have enough information to start
> > preparing to upstream support for it. This series lays some ground work;
> > splitting the bindings and dicing the implementation up a little further to
> > facilitate differences between the 2600 and previous SoC generations.
> >
> > v2 addresses Rob's comments on the bindings conversion patches. v1 can be found
> > here:
> 
> I have applied this series, I had to strip some changes of the header
> because it was based on some SPDX cleanups upstream but no
> big deal I think. Check the result please.

Thanks. Have you pushed the branch yet? I just fetched your pinctrl tree
and can't see the patches.

Andrew
