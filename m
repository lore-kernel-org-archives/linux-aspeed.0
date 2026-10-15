Return-Path: <linux-aspeed+bounces-5195-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5BDCC6B34
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Oct 2026 07:44:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j50Th0StDz3048;
	Thu, 15 Oct 2026 18:44:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792050295;
	cv=none; b=XoV6eSUJdzTFGxWL42jpeILehooPMk5GZu34bQBgetxbtB5EfMOZqkkpqvdKUIvnRVnVLMFIYs3AuOhJUBwperNavBpwe/7wNVb+G+owj5aQwWJZMtVz/h1GIj81RJEL1m/uEH39jPwbXjqdwChp4N6zDm6L/L7ITlTt6CAxUkDN0knUgDKSIppNXNjX4L3v9AqNVNKB+sFdZRkg3kkioFH/rdwA3kVdiC6Nr7EUk7aIdZYqG/6E/K6FcyIZcCxze+k0E6jrQZ3hdUKpD4H7tzTbhkdVB6FJKTR0c3URqqVcJ+uvLh07vxyf4jNmOAFiRO4LNEXRLq6XT3g/fx6uHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792050295; c=relaxed/relaxed;
	bh=+dvMNnzmsfKlXaQReE9W1eWaATaq+JUXJSwSZca7lFE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JsnC2lOody5qsgQ0ASdtPvHx6CftI+lTNQKJnavRS1ocMB1DvCiCWWbnE3ZdbCywEc3CoKfk9Q0CGVAQ8JdpaQta98ToWoDCbA75OU9S9cWhwMBsVdqb0MGCy8/fbkyozFDDDcazbPFqdwVy7c75FKMyP1ChqluQh/o/SPXGQEAg3QG/kqKA2Dd04UUA8JQNTQR6mBH2GIopi+Wkqmu+Ja2stN+0Y2TjWHzXcVU4erj3lMK8kOPJ2EZt4drBaxolwGogDeAT5w/ga0jNuPe3xNjV+azmmEhWz1XO4SiBflW6UQrgSykXCnDgrxK/ZDB8VRbTqd/UPsIjqRFpFLESjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=k5fhz4HC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=neil.armstrong@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=k5fhz4HC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=neil.armstrong@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j50Td3W9lz2yjw
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Oct 2026 18:44:51 +1100 (AEDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-48af27fe287so53198f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Oct 2026 00:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792050283; x=1792655083; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dvMNnzmsfKlXaQReE9W1eWaATaq+JUXJSwSZca7lFE=;
        b=k5fhz4HCDjEuZZgI7nbN0SQWN47zm/1v5NQVoa1BBpbzB3KBbCSI5JZez1cEnYWF2F
         s8haoiwlDHJVyzl+3o3y6I2S0ltpeOhrHRNXC7ZWCvhFDpuKNvz1pQdM1j8WKDV31vlx
         FvgccSyD3vDeuDbft67yPUuTAoGRfc8RiyPyGX0QOPG9nfFhME3qqrmPmq0kQh6J5GUP
         l4PnNwLPL07hB6JUl5slCAHxaubM57T8zSB4nAShkmC8SE2XG4MB5TWIhccxX7ak962+
         gYf/q5hR/qLtDf26DH3bYNlFANXP7gqblvKBOnQqKdDfvpro/jYmu9JuQwX83rq7KKcg
         MbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050283; x=1792655083;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+dvMNnzmsfKlXaQReE9W1eWaATaq+JUXJSwSZca7lFE=;
        b=b3W70dvockQJvbeZAwv6KEmBYwCYYLN0S/I7U19nJTk44sHH3N2KeKzZiISjtUyE3f
         qqMz4H6gHawIsKM7m9vwVJK/g/Dmmy1Y7rWShVIPmYgMFCAYfgxFipB/BI7f2Tjkgm4K
         IJD8yqG1xvNks2ndnXpyAA5dopayrNho2slqxJhorBVk7Hvapy1R8Ba7YuPMyYTYWaSY
         EQm75G9ONxOO1b5jfy7YYIjE/Ks7u0ZdS51PrL7Gzs/qVCPWYSqCDk39Yew8xGv+l3Ot
         rCc2mtuihDvVAmB61vQ6EDyeiUqqRBEJSTAGhG/6NQmhbupktWEF4YAp9Zx8YCZrlD5x
         4viw==
X-Forwarded-Encrypted: i=1; AKwUvBx4ryUEwKqMLT6R0oopv1a3Fye0sJ0q644Jl1ozH5HX/vXOzSyBml4gzcOAr7D5ULCjRAWhqlPZIG7ak9w=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKwjfmDbf4w1ckQw4aXdTuAcPrPSdqsnFVG09g403UbT4muvwTc
	BCp+ks1uHnC9d+6mBb1mDWZJvI/vWmJnVZOqY16ZNA8sapUEumkOakIBNGJzfddFldk=
X-Gm-Gg: AYBFou3VPkKk0soAKFOtVaEPi34gDWxKDnX0wvx2MSNudHeqtiDEZwzraQa0HOrtYar
	12QrnliolbsHsMJIZ2C6ihUwKllXnIlLTLcvFmxOfTBgJqeAarxNel8gB/PFbIii/s0WnzjIgN4
	XzjMEoH6lBPo6M3YT7CGdk54Y3EoN5KfLQ1dRvZpumlnDtcH3sDGL7F1dWS9usIW+o8fMPlzJo7
	thTHQBJv/yZrO4C4869hf0aawvPGt4nBXydonogqsWHRB22ZU5aL/CJL9QHViFWkvvuF+Vq8yD0
	8hv1pDTIgs/aXCt0x2dJtUklRZIpYqW1KeN9ZO1twnca/+1eh64iEACzSFmiBupoqlLnzoRgb9P
	lTCcj7DZl1RtXun+9ZXvYrFHURhNMmblYLdcYYlrsv6cIGwW+NCwdOzoxmmQZt3vqprwJMDvQKq
	J91u9QIcqSOPZLUHRKcXNLIrViXgEF4lOkXlSKEko7MIcWsB5z2dFOdrA3IYPUCUtwbb8EfmvCW
	ZZn0HOPBs6DJZmxfzAToNAwD668tzSEts4b6kUg4l0529KwO/S4ahs=
X-Received: by 2002:a05:600c:4685:b0:4a0:27eb:49b with SMTP id 5b1f17b1804b1-4a18e4ae6fcmr385008175e9.30.1792050282515;
        Thu, 15 Oct 2026 00:44:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:fdbf:f373:6d5b:93e4? ([2a01:e0a:106d:1080:fdbf:f373:6d5b:93e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48ded185de7sm8548506f8f.31.2026.10.15.00.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 00:44:42 -0700 (PDT)
Message-ID: <8d4d3ec2-3c97-4a46-97f8-048fdf81b853@linaro.org>
Date: Thu, 15 Oct 2026 09:44:40 +0200
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
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Fix downstream port
 numbering
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <balbi@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Michal Simek <michal.simek@amd.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peter Griffin
 <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Alim Akhtar <alim.akhtar@samsung.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Wei Yang <yangwei1@eswincomputing.com>,
 Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
 Hang Cao <caohang@eswincomputing.com>, Li Jun <jun.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Roy Luo <royluo@google.com>,
 Yang Xiwen <forbidden405@foxmail.com>,
 Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
 Robert Marko <robert.marko@sartura.hr>, Xu Yang <xu.yang_2@nxp.com>,
 Wesley Cheng <quic_wcheng@quicinc.com>,
 Stanley Chang <stanley_chang@realtek.com>, Ze Huang <huang.ze@linux.dev>,
 Aswath Govindraju <a-govindraju@ti.com>, Roger Quadros <rogerq@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-aspeed@lists.ozlabs.org, imx@lists.linux.dev,
 linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
References: <20261014082037.1774672-1-wenst@chromium.org>
 <20261014082037.1774672-3-wenst@chromium.org>
 <7020a7a6-332e-4fd0-a659-d82eb768614c@linaro.org>
 <CAGXv+5G1kgyumbj7wGf6rPFbg3spSO0zYmEkn-hZT4qUdJbytA@mail.gmail.com>
 <03375a31-0ac6-47a4-b0dc-6327080e1622@linaro.org>
 <b4c0761b-34f2-42ad-97e7-ab34ae776281@oss.qualcomm.com>
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
In-Reply-To: <b4c0761b-34f2-42ad-97e7-ab34ae776281@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/26 18:36, Konrad Dybcio wrote:
> On 10/14/26 11:44 AM, Neil Armstrong wrote:
>> On 10/14/26 11:29, Chen-Yu Tsai wrote:
>>> On Wed, Oct 14, 2026 at 5:28 PM Neil Armstrong
>>> <neil.armstrong@linaro.org> wrote:
>>>>
>>>> On 10/14/26 10:20, Chen-Yu Tsai wrote:
>>>>> The DWC3 controller can operate in host mode. It does so with a XHCI
>>>>> compliant host controller. The XHCI has two downstream ports, one for
>>>>> HS and one for SS. USB downstream ports start from 1, not 0.
> 
> [...]
> 
> 
>>> IMHO having consistent numbering across controller types would be
>>> better. This avoids making the USB core and hub code deal with more
>>> exceptions, and also easier to understand and write device trees.
>>
>> I was in the impression the port number not necessarily reflects
>> an actual physical numbering, and can be a logical number we would
>> then map in the kernel.
>>
>> I don't see any issue here having base 0 for the bindings and then
>> converting it to base 1 for the XHCI port numbering.
> 
> I thought base1 comes from the USB spec and not just XHCI?

This is my question, is the spec says: each USB Host Controller root
port shall be considered as a port of a Hub and numbered the same way,
then fine, let's use the base1 numbering.

As I understand how USB is architectured, all downstream ports of Hubs
are numbered in base1, and the whole topology is based on that.

But here, we are speaking of physically separate USB busses, one
USB2.0 and one USB3.0, a controller could also have 10 USB2.0 ports
and 5 USB3.0 ports, who knows. The way those will be numbered is not
part of the specification because the specification only the defines
the topology of an USB bus, like PCI(e) defines the topology on a PCI(e) bus.

How we aggregate all those busses to abstract them to software is not
part of the spec, we chose to declare a fake root Hub with a physical
downstream port as a virtual port of the root Hub, fine but this is
purely software abstraction.

We may only use the hardware IP port numbering in the bindings, not
the software abstraction.

We could use the base1 to describe the DWC3 ports, but how to describe
all the physical USB busses a controller can expose ? We may not limit
the bindings to USB2.0 and USB3.0 ports only.

How about the USB4, does it use the USB3.0 port ?

Neil

> 
> Konrad


