From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Thu, 27 Feb 2020 10:16:59 +0100
Subject: [PATCH 2/7] docs: dt: fix several broken references due to renames
In-Reply-To: <83c5df4acbbe0fa55a1d58d4c4a435b51cd2a7ad.1582361737.git.mchehab+huawei@kernel.org>
References: <cover.1582361737.git.mchehab+huawei@kernel.org>
 <83c5df4acbbe0fa55a1d58d4c4a435b51cd2a7ad.1582361737.git.mchehab+huawei@kernel.org>
Message-ID: <add18b30-6eec-9aba-a961-8ecfe9b32596@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22/02/2020 10:00, Mauro Carvalho Chehab wrote:
> Several DT references got broken due to txt->yaml conversion.
> 
> Those are auto-fixed by running:
> 
> 	scripts/documentation-file-ref-check --fix
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ ... ]

> diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
> index d9fdf4809a49..f3e68ed03abf 100644
> --- a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
> @@ -17,7 +17,7 @@ description: |+
>                  "brcm,bcm2711-avs-monitor", "syscon", "simple-mfd"
>  
>    Refer to the the bindings described in
> -  Documentation/devicetree/bindings/mfd/syscon.txt
> +  Documentation/devicetree/bindings/mfd/syscon.yaml

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

