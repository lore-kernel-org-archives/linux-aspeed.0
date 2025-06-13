Return-Path: <linux-aspeed+bounces-1439-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A74C61DB2
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 09:14:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJYcr13Vyz30P3;
	Fri, 13 Jun 2025 19:14:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749806075;
	cv=none; b=TA5x3dRhInPDTFNzQnvVIeeQq0/aBnkwo2ye0J4IfoLxcxFFmBvY6JOqwopmyaQ/1Y9Bf/18o8dLNL7TSxMAuhb3WX/ZZ7mWtznIr1DYTvSO2cVlFZii47NP/E9ZMN1ZeQ72f9twnHLpsrl6o7W9Fj4NS1NunazFcuh8eD7Yb73Loe/vywgaC+W2LqNah/Cx+6XrzBA0MVWm8N8FM5O/mcXaeGxUjY9VIUJevsr765tsP7/RjjBngYFn6D3Q+gP7anFqXdxhflxuwC4ZTR4Q56G+svCkH+e9s1Ng9DxeejeFwwQ+AUxuo8W8Hcm1+GPrUrkzrcp7nZwepOAeo2lSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749806075; c=relaxed/relaxed;
	bh=QxfIULPvH1TVJo+Bp0irHce0KEkyksYpcZ/Cbp7r00Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YsvJF9SDSZ7IOt1CbmUY5pMAUu8DnZh4dXqZqbM6Yq5VlYeyuaart/BDR7NBefSoKeaazBtQF7Q/+CVwoYKwGXCSC9Cj6/dNkc4v7jbAoWPHSL2vx7oXCHoltiHkiBX6MQ4cvgQApYGLs6nsn5Cm37uVQMNaORi1a9IVPKA9xwBfVDWMtsC/S4nxSI2rdrc4sp8JEHozndXX8228lNRb5uurmF98TJ/sIpmFsRa6P+jxhi7js9fKsG7QU+86i+CY092X18rC7u4+RzlhrN+0JJX4Nbi2VT0VU0DG3uz+GklCYt7/JCrB6AXT0w3yPV6YHzQz0q75RVai8A4hLStRXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yx85df/9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=neil.armstrong@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yx85df/9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=neil.armstrong@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJYcp1bmrz30NP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 19:14:33 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3a54700a46eso1479659f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749806068; x=1750410868; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxfIULPvH1TVJo+Bp0irHce0KEkyksYpcZ/Cbp7r00Y=;
        b=yx85df/929c9boTqn0hvEnn9ClMPOgPjLRDHSEWyrKmWP8tZKeeRPh87ztHWNlcEuh
         QOrRDTbbS4C2k/9IF8fCBcj7aRzML/hFW0lOEe5OsQJZ9YrnshW+tO5QzINBPXh1u/Mn
         wL2oAJTSk/nWaNUlf7wLx5bCzDKjrQs7rDlbFicWpthHozl20rxRMjQEwNbj4MeBWWkt
         coe0fFd2j3mn/8UB1FDv5q5sp0TaGCpAe7L5c5yBbAhLlCpL0elwnKD/Junuvq8d6iEj
         bDCDf5o3Kmy04Fljo4Kl/Ri/peIlZ1rAzkFZeyHOog5JvvkVovf0clNNr/BUjzg6KhbC
         /bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806068; x=1750410868;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QxfIULPvH1TVJo+Bp0irHce0KEkyksYpcZ/Cbp7r00Y=;
        b=RGRc2JnGBbmfm3qmfc1xpJV9YO+firtXILtzcnFSHBCuQhLvBiv9YNGo8LZkHQn95O
         lVPhaHHTbowcugBkdz/z48kDIHLvyc374/1VSCDxXKc5iVrZRDElUO+EOxZYyRz4k0gJ
         M/Ja1dnYLnNleFXbILc4ThCrJayfM3XXKaR+uVxyoUx/j8FCowH+HqxQaZ8ZxeaWRoeI
         uhXIArnkyZJf7SwrCGQ6WtjpRxmhDS4Lko84Gk55ohwqCCAF/pUwu5Izl1XV9W19SrCZ
         f8lDqvTCOLIFBqHUYUVBxe5E5aDur7dRPXLSNcKow91RE0vDnVRbVs3jAL7MrVY1RnHU
         j5pw==
X-Forwarded-Encrypted: i=1; AJvYcCVkofgdZ16DO1aEA9YLcVgp2RHm5h40iV4e2OMYrgQDqFo+QecxOgfB6PTf0smqSLOoc2R+DQnADMArUZs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwCSkJCk1dNbKsJLG/SANIJGzJlXlaADmG0ZvA2qiuk6Ma24u+I
	I4vcTBD/1TBze3xqsHhN7qh6fXcgFug3FtltXFtpKo0+45iZ7WG+/OEIF3IL/edMGUg=
X-Gm-Gg: ASbGncslQN7Y1gL1voeJKLjs9SrbfTtnDcdmoBmobVJLjiRcvgM/t/B2l5m+TYJaQtj
	VvAYhAB/L/R9Wq9/VI6mW9uArtGGPhxZsYT5Cg1eyz2Rsz57EEUCCq4neumuQAHO6ch61XQx0SZ
	o7VolxxPSE9FLIEvhQfESnqvSrhF0ccbQfljfOig8Zj5qSE/GKplmZ6mxApP2AaH3XQtwSQ326A
	UanixOjoW/j4bL8YApGv2lZccjrcv6iHBtLqpsfI6skRZ9NdODhxkcBzFIFpqGM5x9uWSC9kcij
	NrkkmexuyNqa/184pLJu/sicyaIJ0MpO6JjCVRnDomXMMBZC+HdmD5zL1mNt34NKGMBwmTf9yRP
	S9WkqQuw3uhXWLFSEuwopjliBL/1nrkRtelG6mt4=
X-Google-Smtp-Source: AGHT+IGQOFD/EY7S2QDUIKx6X5WFj8qb8/qrnjFsfEXjcL1hzrA6uPRMdM2o+qwKrI1AezZg1EjOrA==
X-Received: by 2002:a05:6000:1445:b0:3a5:52cc:346e with SMTP id ffacd0b85a97d-3a568655fe0mr1850481f8f.6.1749806068043;
        Fri, 13 Jun 2025 02:14:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4144:6a84:fe1d:3aae? ([2a01:e0a:3d9:2080:4144:6a84:fe1d:3aae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54a36sm1781165f8f.15.2025.06.13.02.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 02:14:27 -0700 (PDT)
Message-ID: <5d624bce-a46f-4b75-b785-56def0c7f108@linaro.org>
Date: Fri, 13 Jun 2025 11:14:26 +0200
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
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/7] dt-bindings: phy: Add document for ASPEED PCIe PHY
To: Jacky Chou <jacky_chou@aspeedtech.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, vkoul@kernel.org, kishon@kernel.org,
 linus.walleij@linaro.org, p.zabel@pengutronix.de,
 linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org
Cc: elbadrym@google.com, romlem@google.com, anhphan@google.com,
 wak@google.com, yuxiaozhang@google.com, BMC-SW@aspeedtech.com
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
 <20250613033001.3153637-2-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250613033001.3153637-2-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2025 05:29, Jacky Chou wrote:
> Add device tree binding YAML documentation for the ASPEED PCIe PHY.
> This schema describes the required properties for the PCIe PHY node,
> including compatible strings and register space, and provides an
> example for reference.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>   .../bindings/phy/aspeed-pcie-phy.yaml         | 38 +++++++++++++++++++
>   MAINTAINERS                                   | 10 +++++
>   2 files changed, 48 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/aspeed-pcie-phy.yaml
> 

<snip>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5a650812c16..68115443607d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3696,6 +3696,16 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
>   F:	drivers/media/platform/aspeed/
>   
> +ASPEED PCIE CONTROLLER DRIVER
> +M:	Jacky Chou <jacky_chou@aspeedtech.com>
> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/aspeed-pcie-cfg.yaml
> +F:	Documentation/devicetree/bindings/pci/aspeed-pcie.yaml
> +F:	Documentation/devicetree/bindings/phy/aspeed-pcie-phy.yaml
> +F:	drivers/pci/controller/pcie-aspeed.c
> +
>   ASUS EC HARDWARE MONITOR DRIVER
>   M:	Eugene Shalygin <eugene.shalygin@gmail.com>
>   L:	linux-hwmon@vger.kernel.org

Please move the MAINTAINERS change in a separate patch.

Thanks,
Neil

