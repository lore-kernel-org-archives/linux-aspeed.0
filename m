Return-Path: <linux-aspeed+bounces-979-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D616C28B2F
	for <linux-aspeed@archiver.kernel.org>; Tue, 11 Mar 2025 07:34:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBlsG2C2wz3bmf;
	Tue, 11 Mar 2025 18:34:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741678498;
	cv=none; b=bzRXhDVxyU6JAWAgkzEzKXFRpMD9Y5y8wk1ClInY50av75qQntRzTVV0rmnhfDDCLBIUU9sS33FD3EueM9VQMjYSuamd52Wm6Yq/32Vlno/UIEvIiW6CLSfvgW+TnbQnX/IEy00BZyMEHZgniuu39QfGVEdKn4l0PMcBNX/1y93Bk1mr7+lGxiWhEeN/al4f4kL1Kco1efb3SS1e//t4DEv6bwOni1uprp7K4lqXXxErUrWNVCRcnveLSoLV8R35yDail2azY+8MN9Bs6ZOdNfLIfsDytmk3aWjWX5yyocWqHHt9fGqlacQAiaHGa1I1B3ZM3mK3nbSUVXbm/DAJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741678498; c=relaxed/relaxed;
	bh=L1mvUPTMlzS5MK+oJKCmujIlWmPMPrf8qizbNHkT0po=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cezqotSNTBQwJww8Y7xpqfLtN0yxCrdEADrbNu9venabeDtVzwIRowswHMwFucxJUU6rMrarjQIJ2UX7QLnuG8gQOHPydJgFT+phMqM5COwN174XXuGLXcJYrBa8O/QXVUnb9I4anWHPoaI+3lBq2w1uN/O37Zoh5Omzdtc8daCi4Jqcn4ns6KvXpJ2/+y3F2HKzkh7NO3OW8SyhTJs90Z81iSnIxg8ZZSGtcvMVzI5TPXPmqJvBQJ4ld8yEyKygQlw21YsQt0w61eIRl2XNQ7YgRELGHk2rvenlWSQajToZYliDkqAhwDmEb09ZzOpCXh5kn+bfeuOcTgq9B25tnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Go4JXtJJ; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Go4JXtJJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBlsD5F9Zz3bmJ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Mar 2025 18:34:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F07755C4D45;
	Tue, 11 Mar 2025 07:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81256C4CEF1;
	Tue, 11 Mar 2025 07:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741678494;
	bh=wg4YeqiedkYDu3lKghALGd0dLR7nHsUD6V3DaDuourY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Go4JXtJJ9gcw5EXueFYSF68kMoS7kIGslH/44LM4z2SDkDs9EwoYgqefiDjTSm/x3
	 1mleB1CI41XUYyNHJZTicmiYrtHhwXe+LYINg8A0SMVJTefD0nJKe7K5uZTBmAt0rW
	 WBxA1xaPimtk7NcNJgr7+/kmK9tSqx/5wQH1a0h8KGwYaOwrsCV1ZuStLmDIBqLxsr
	 DsTCwfeLnSdaksWJlCUJfshx2MUz5JEwUDxFDi0iSjR2QOnLBC5/Vydty0FKkbQsSF
	 YPEXhtUcMa2JqZXYA78oxY+1OOmHIx8oE4QH6N4Fp6Sw+KwVkUuJ2c6tZGneXfiSqe
	 pvWGdyc/uwijg==
Message-ID: <0e30c12f-5ac5-4008-8cc8-ec4111520655@kernel.org>
Date: Tue, 11 Mar 2025 08:34:47 +0100
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
Subject: Re: [PATCH v3 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, derek.kiernan@amd.com, dragan.cvetic@amd.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250310114839.3098148-1-kevin_chen@aspeedtech.com>
 <20250310114839.3098148-4-kevin_chen@aspeedtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20250310114839.3098148-4-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2025 12:48, Kevin Chen wrote:
> +static int aspeed_pcc_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct aspeed_pcc_ctrl *pcc;
> +	struct device *dev = &pdev->dev;
> +	uint32_t fifo_size = PAGE_SIZE;
> +
> +	pcc = devm_kzalloc(dev, sizeof(*pcc), GFP_KERNEL);
> +	if (!pcc)
> +		return -ENOMEM;
> +
> +	pcc->regmap = syscon_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(pcc->regmap)) {
> +		dev_err(dev, "Couldn't get regmap\n");

return dev_err_probe() is not suitable?

> +		return -ENODEV;

Why overriding error code?

> +	}
> +
> +	rc = of_property_read_u32(dev->of_node, "pcc-ports", &pcc->port);
> +	if (rc) {
> +		dev_err(dev, "no pcc ports configured\n");
> +		return -ENODEV;

Why overriding error code?

You got this comment already at v2.

> +	}
> +
> +	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (rc) {
> +		dev_err(dev, "cannot set 64-bits DMA mask\n");
> +		return rc;
> +	}
> +
> +	pcc->dma.size = PCC_DMA_BUFSZ;
> +	pcc->dma.virt = dmam_alloc_coherent(dev,
> +					    pcc->dma.size,
> +					    &pcc->dma.addr,
> +					    GFP_KERNEL);
> +	if (!pcc->dma.virt) {
> +		dev_err(dev, "cannot allocate DMA buffer\n");
> +		return -ENOMEM;
> +	}
> +
> +	fifo_size = roundup(pcc->dma.size, PAGE_SIZE);
> +	rc = kfifo_alloc(&pcc->fifo, fifo_size, GFP_KERNEL);
> +	if (rc) {

Drop {}

> +		return -ENOMEM;
> +	}
> +

Please run scripts/checkpatch.pl and fix reported warnings. After that,
run also `scripts/checkpatch.pl --strict` and (probably) fix more
warnings. Some warnings can be ignored, especially from --strict run,
but the code here looks like it needs a fix. Feel free to get in touch
if the warning is not clear.



Best regards,
Krzysztof

