From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 08 Apr 2020 09:06:25 +0930
Subject: [PATCH] ipmi: kcs: Fix aspeed_kcs_probe_of_v1()
In-Reply-To: <CACPK8XfA-4WvgVeEKi-hdC-LgEcicEhpV_0ivwymaEJKy15hGA@mail.gmail.com>
References: <20200407122149.GA100026@mwanda>
 <CACPK8XfA-4WvgVeEKi-hdC-LgEcicEhpV_0ivwymaEJKy15hGA@mail.gmail.com>
Message-ID: <0744752b-a48e-4edf-ba77-df605fd242a9@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 8 Apr 2020, at 08:48, Joel Stanley wrote:
> On Tue, 7 Apr 2020 at 12:22, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > This needs to return the newly allocated struct but instead it returns
> > zero which leads to an immediate Oops in the caller.
> >
> > Fixes: 09f5f680707e ("ipmi: kcs: aspeed: Implement v2 bindings")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks for the fix Dan.
> 
> Andrew, I think this means no one has used the v1 bindings in
> mainline, so could remove that code?

No, rather Dan's on the ball and it seems I was a bit lax with my testing
of the patch. I pinged Corey only the other day regarding the patches;
he had been busy and as such hadn't merged them.

I have a series to convert our devicetrees over to v2. Now that Corey's
taken the patches I can send that and we can get away from v1.

Thanks for the fix Dan.

Acked-by: Andrew Jeffery <andrew@aj.id.au>
