From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 26 Aug 2019 12:20:59 +0930
Subject: =?UTF-8?Q?Re:_[PATCH]_media:_aspeed:_fix_an_incorrect_return_code_on_buf?=
 =?UTF-8?Q?fer_allocation_failure?=
In-Reply-To: <588f6cbd-b6ca-4f43-8034-80956ee56bb8@www.fastmail.com>
References: <20190823212957.26043-1-jae.hyun.yoo@linux.intel.com>
 <588f6cbd-b6ca-4f43-8034-80956ee56bb8@www.fastmail.com>
Message-ID: <758d249b-81c1-4e26-b3d5-ce79d86231b9@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 26 Aug 2019, at 11:02, Andrew Jeffery wrote:
> 
> 
> On Sat, 24 Aug 2019, at 07:00, Jae Hyun Yoo wrote:
> > It returns '0' even when a failure happens on jpeg buffer allocation
> > so this commit fixes the issue.
> > 
> > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Keep my Reviewed-by, but can you please do a v2 that adds a Fixes: tag
and also Cc stable with the patch?

Cheers,

Andrew
