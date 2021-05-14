From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 14 May 2021 11:25:51 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_06/10]_mmc:_sdhci-of-aspeed:_Remove_some_unneces?=
 =?UTF-8?Q?sary_casts_from_KUnit_tests?=
In-Reply-To: <20210513193204.816681-6-davidgow@google.com>
References: <20210513193204.816681-1-davidgow@google.com>
 <20210513193204.816681-6-davidgow@google.com>
Message-ID: <24e8c5e8-d1eb-4e42-b8de-c60c5cceaf85@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 14 May 2021, at 05:02, David Gow wrote:
> With KUnit's EXPECT macros no longer typechecking arguments as strictly,
> get rid of a number of now unnecessary casts.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> This should be a no-op functionality wise, and while it depends on the
> first couple of patches in this series, it's otherwise independent from
> the others. I think this makes the test more readable, but if you
> particularly dislike it, I'm happy to drop it.

No, happy to have that cleaned up.

Thanks David.

Acked-by: Andrew Jeffery <andrew@aj.id.au>
