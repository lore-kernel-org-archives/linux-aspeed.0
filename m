Return-Path: <linux-aspeed+bounces-580-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F065C0218D
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 15:43:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjmfP05Rmz305Y;
	Thu, 30 Jan 2025 02:43:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738165436;
	cv=none; b=a4X+IcuWPMBUQ0yotTE2XBTKKvjyMT3emxEPvhqz2AkfvI+5muXm4Dc3FhHzaYc6YP6bTJ6ccxlRkbiww9Z2G0EV+Kf8sKcsIiWaFZhiMa3Tg9JO2YcSg4YJ0TusWRvDwosqa+uBQQ+tiJVhXwkE9kS6X1BeXX6MbdVk1EqoVvPjtI/ivero83808zsgVPDlzYya+2wt4qe28IcP9G29TIEGdNg9BPxQp3vSDdJ0OY+Q9Ya45e9OU01fhNeRt37PzNHVLnj5rrZpYzDTCMJKV1W6jAGKGW5iqhz6PH6n7XQsmpGTZxzt5kyBo2GTbr5wdW5XyA/X6UM8mkJz0nviCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738165436; c=relaxed/relaxed;
	bh=hPHIr1AdUQXL4S8PLOw7faEqsccJFgDRWTAC+UQvuk0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S3Xx1/jUsTawOUL7xih9qKfsN0Sehv79oWj9zsPLgJfD+d9aiPaFQfa64qjICkqjx2Fuh2Zoh8jJ5DdNBaNlsVydKeXB4v7l9tm0AVLUTsCjbremTRMRPVv9l/wLwB66V+WEaAq1GhwsU9WlLM01B3HEL7IfQxfE7CAB7iSbM50s6gBf0hrBviBu1df2ymDh+7pe5r48MIGOf/bJOrfOiie9UhOV1mhXjH4NUDEXvdb7SszYnLQ8r70LEtLzqyJ79VmyAUhxlJovCBtgruv72hgHOZsSoK8ywcn41H2XRjm1Cqi8GbunTlZTmfPGfd0yUzzmpxFWrJ86F3rCPZJuHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PuuHFBH0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=neil.armstrong@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PuuHFBH0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=neil.armstrong@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjmfM6SCjz303K
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 02:43:55 +1100 (AEDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-38a8b35e168so595529f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jan 2025 07:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738165430; x=1738770230; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPHIr1AdUQXL4S8PLOw7faEqsccJFgDRWTAC+UQvuk0=;
        b=PuuHFBH0Sc5CjCIiJ3i67z0pxi4012DwScNlEpI855BpP4aGJ8K6O/pMgMPIj9fQ1n
         j0UT8jEg2O7VNOShfLO9ytVOoma1Xqlhk0QRIGNY5/ymTsUCZogXC65Hm2wO8sjY3Uxy
         KXqdop8nQf4azFWX21B1XyEXtVQGx79XzoKKq0fhWojyfFrS4ETbm9kly3hYyWKy/hW/
         Zo9mlg150L40fuXGsxObmLIsrWQZ+r3A+IBuHjKRj5gN0o9hHpDf2hyb252H0gW7tAYy
         gPF76JlhWKBwpbFpRrdFxsz1HvtZrilDC02Njy/e2KqKpng4/dM+NpzAQudRmh8zV86E
         Ugyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738165430; x=1738770230;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hPHIr1AdUQXL4S8PLOw7faEqsccJFgDRWTAC+UQvuk0=;
        b=xEmgySZm6Z0tSOGNGWn5MWYmQL2LZGfKuavJDfqfqgK1O+ZzZskNYCfkXx5beoKHtG
         F2BSjuAbMUqyxN2X4mVweB+DRQOUbmK9iUOaPd/6EQA7x7zg1n7SeXxrSv2+a6EXJ1PD
         L3RqOz/nq7iP/UwPK6e38HHyFc17l90mEzSAwujaQiNC4j/n76H9OlknGHgeW/o6tKUK
         8dNG1UzYboaZk8UzBKEF/8XavjSM0j9BSVbY7mnokxBhGQnMSunnEg24P+Dpaw2OHv05
         3e0+U3cbpZJmNWlNgpHwU2rPcSikff5kFznoz0VujIKBczq62Am0vqtJMCHQ2Sn2RQBt
         CwYA==
X-Forwarded-Encrypted: i=1; AJvYcCXyvxX7sE8qjZTiqvRfoFnvgsq5gSpfdhQ9N77T+rpPTuhqo5u6WcyWcb2NWsb1a8g1FiUOnwgAkjnemnc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyrPgNpx/k2RHPDk+8wHLvy8CoEdqXzf2B4R6cKmYAEH73zB1RT
	no7Wb0lrpeavFsVAC5odU9MmAzn61uD4MA1yONUMUYuu/6NaqMgpIpsnbwolAGk=
X-Gm-Gg: ASbGncuR8xRBb2Wy3eiBvB97ddPfBh2IFv96cU2Z27OpdBUc65WJCG0THi8h/9tst20
	0H3imm5XqqVXs+okRpB++Y7rHU/jAO71uNCYGqVXk6fZ1NWSwW/rxx3onYnJtBNhySTgm4DTXi6
	32nFFPhfGMgwmirnF2QPsHDO6ZdWQehI0GdnNv7VS0xIJ6+R9+sk+ZfqmXjmO0DN7tdZBbJPvkv
	4DBlFbzHhKYd5TmHErYJGUHNenAsFYkLrJjaTJs4VREe3Et2C2I7kIPGS4BwC12n1xdfFPrVODo
	FwDHxjlC/QBoM+ppBkySyK/dT/JzrQNc1R9sadQWUYgc90k6yjKsOh2vsz9K61P+cnc9
X-Google-Smtp-Source: AGHT+IG+AzLiMQGtSlFoPMZbCjyIVlZSwQQSJOvatG/rHgk08wCvQOFvIicCJd/sEzgRT/WR6JlERw==
X-Received: by 2002:a05:6000:1f81:b0:38a:a019:30dd with SMTP id ffacd0b85a97d-38c50fe7e90mr3136677f8f.8.1738165430293;
        Wed, 29 Jan 2025 07:43:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b25e:a614:863b:566e? ([2a01:e0a:982:cbb0:b25e:a614:863b:566e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188689sm17390387f8f.48.2025.01.29.07.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 07:43:49 -0800 (PST)
Message-ID: <c7c2f630-ee9d-4427-adc4-0d982f9e7593@linaro.org>
Date: Wed, 29 Jan 2025 16:43:48 +0100
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 05/14] drm/meson: move to devm_platform_ioremap_resource()
 usage
To: Maxime Ripard <mripard@kernel.org>, Anusha Srivatsa <asrivats@redhat.com>
Cc: Joel Stanley <joel@jms.id.au>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Stefan Agner <stefan@agner.ch>,
 Alison Wang <alison.wang@nxp.com>, Xinliang Liu <xinliang.liu@linaro.org>,
 Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu
 <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Alain Volmat
 <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-aspeed@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
 linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-5-0d1609a29587@redhat.com>
 <ieknc4dm5ntnqaqz6zdlinphocm2omsn4ll34vlbrohqcddl43@kg35irldnkuw>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <ieknc4dm5ntnqaqz6zdlinphocm2omsn4ll34vlbrohqcddl43@kg35irldnkuw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/01/2025 16:40, Maxime Ripard wrote:
> On Tue, Jan 28, 2025 at 05:29:29PM -0500, Anusha Srivatsa wrote:
>> Replace platform_get_resource_byname + devm_ioremap
>> with just devm_platform_ioremap_resource()
>>
>> Used Coccinelle to do this change. SmPl patch:
>> @rule_3@
>> identifier res;
>> expression ioremap;
>> identifier pdev;
>> constant mem;
>> expression name;
>> @@
>> -struct resource *res;
>> ...
>> -res = platform_get_resource_byname(pdev,mem,name);
>> <...
>> -if (!res) {
>> -...
>> -}
>> ...>
>> -ioremap = devm_ioremap(...);
>> +ioremap = devm_platform_ioremap_resource_byname(pdev,name);
>>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
>> ---
>>   drivers/gpu/drm/meson/meson_drv.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>> index 81d2ee37e7732dca89d02347b9c972300b38771a..6c805805b7a7f675f8bb03944318972eb4df864e 100644
>> --- a/drivers/gpu/drm/meson/meson_drv.c
>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>> @@ -184,7 +184,6 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>>   	const struct meson_drm_match_data *match;
>>   	struct meson_drm *priv;
>>   	struct drm_device *drm;
>> -	struct resource *res;
>>   	void __iomem *regs;
>>   	int ret, i;
>>   
>> @@ -220,14 +219,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>>   	}
>>   
>>   	priv->io_base = regs;
>> -
>> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
>> -	if (!res) {
>> -		ret = -EINVAL;
>> -		goto free_drm;
>> -	}
>>   	/* Simply ioremap since it may be a shared register zone */
>> -	regs = devm_ioremap(dev, res->start, resource_size(res));
>> +	regs = devm_platform_ioremap_resource_byname(pdev, "hhi");
> 
> Given the comment, this one should probably be skipped.
> 
Yes please skip this one.

Thanks,
Neil

> Maxime


