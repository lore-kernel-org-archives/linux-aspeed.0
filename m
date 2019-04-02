From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 2 Apr 2019 14:05:49 -0700
Subject: [PATCH 3/5] media: dt-bindings: aspeed-video: Add missing
 memory-region property
In-Reply-To: <1554229504-5661-4-git-send-email-eajames@linux.ibm.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
 <1554229504-5661-4-git-send-email-eajames@linux.ibm.com>
Message-ID: <c715fe6d-d443-c9b4-0a58-29941e0ed539@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

On 4/2/2019 11:25 AM, Eddie James wrote:
> Missed documenting this property in the initial commit.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   Documentation/devicetree/bindings/media/aspeed-video.txt | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
> index 78b464a..346c2d3 100644
> --- a/Documentation/devicetree/bindings/media/aspeed-video.txt
> +++ b/Documentation/devicetree/bindings/media/aspeed-video.txt
> @@ -14,6 +14,11 @@ Required properties:
>   			the VE
>    - interrupts:		the interrupt associated with the VE on this platform
>   
> +Optional properties:
> + - memory-region:
> +	phandle to a memory region to allocate from, as defined in
> +	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +
>   Example:
>   
>   video-engine at 1e700000 {
> @@ -23,4 +28,5 @@ video-engine at 1e700000 {
>       clock-names = "vclk", "eclk";
>       resets = <&syscon ASPEED_RESET_VIDEO>;
>       interrupts = <7>;
> +    memory-region = <&video_engine_memory>

nit: a semicolon at the end of the line.

>   };
> 
