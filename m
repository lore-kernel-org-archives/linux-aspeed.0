From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 30 Apr 2024 10:58:57 +0930
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
In-Reply-To: <20240326103549.2413515-2-Kelly_Hung@asus.com>
References: <20240326103549.2413515-1-Kelly_Hung@asus.com>
	 <20240326103549.2413515-2-Kelly_Hung@asus.com>
Message-ID: <6b69a2bbfa713374e0bbd9f306ee554ee99f70d3.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-03-26 at 18:35 +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.
> 
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>

In addition to the concerns of others, your author email is not the
same as your SoB email. checkpatch warns:

```
WARNING: From:/Signed-off-by: email address mismatch: 'From: Kelly Hung
<ppighouse@gmail.com>' != 'Signed-off-by: Kelly Hung
<Kelly_Hung@asus.com>'

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-
inplace.

Commit bb035db4c70a ("dt-bindings: arm: aspeed: add ASUS X4TF board")
has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
```

Please fix this issue for both patches in the series and resend.

Thanks,

Andrew
