From: Rob Herring <robh@kernel.org>
Date: Wed, 24 Apr 2019 16:17:32 -0500
Subject: [PATCH v2 3/4] media: dt-bindings: aspeed-video: Add missing
 memory-region property
In-Reply-To: <1556119020-7609-4-git-send-email-eajames@linux.ibm.com>
References: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
 <1556119020-7609-4-git-send-email-eajames@linux.ibm.com>
Message-ID: <20190424211732.GA18914@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2019 10:16:59 -0500, Eddie James wrote:
> Missed documenting this property in the initial commit.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - Add missing semi-colon
> 
>  Documentation/devicetree/bindings/media/aspeed-video.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
