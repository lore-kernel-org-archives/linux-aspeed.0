Return-Path: <linux-aspeed+bounces-822-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59251C021A4
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Feb 2025 10:15:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1c7S09K8z300g;
	Mon, 24 Feb 2025 21:15:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740392131;
	cv=none; b=A8YeppYvqIIn4M2/frQj0ljpZk3QI4AEAkgm/ewvS0nkz6AaNErMoe+Jx4D9jpO8twba+6NnjIxC9h914++uOAjAjVoCfgWIimGjLe3KwctEDBKE0Yc3niZjHkeR2x1hoT4OXwVzCxj2a+gIV5BbgDaSpsBaePQVmwQdSkNBrnEV869hK455JlOlBn5KnG2EKbQy57iaqLwhsrKkCbyWPCusCXXJQIWL4+vmoHbSpPWFAZTjOwG5eCb8qEfGgqjTP3PINGe3RxfCa8KkVm9sMcs8kvUKOiH662iHftKFkRLZg935/4mL6B5QnVVXw9kDN9HPKjwRdJzADYEuaJuK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740392131; c=relaxed/relaxed;
	bh=NP6KwitEnDLK+EJyz6Py7uDR66RPflahZM9CtHgTPDQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=JfXKmXa0reAuuDq0H6R21LBtD4AIXFHwI/LK8TTl1Hf32IX0jnKZWFa6uPGIRVslpSRxWu4DY0js/SIipnmDFip84l3S0A6rGXAApVyHAIUWv2shiYnuDlJwk201mFutbzni0VMEEYKgqT0QEWD64WFpyGPBBgiJGraK/95mx7dG9Np1gzBLMdaBIGLeniXvG0iq4cVSMlMjdZ1eRFNQqOy2CZCw1d7cpkoSOtsX7vK/FypCC6EhaHxAHRHXjrsejZVP3tbBzjpBhVAIksum+1KRs7qwf8Wzw0zrwJ7ZTYQTc8KrLea1xn7kB/efYysnEgqXAn/XDOLDNPX/rqVBtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R6VXbhAr; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R6VXbhAr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1c7R1S77z2xKN
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Feb 2025 21:15:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 59A7C5C624C;
	Mon, 24 Feb 2025 10:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C60C4CEE6;
	Mon, 24 Feb 2025 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740392129;
	bh=nhdDyfK9oxoqYCHrduTPMT827OPl9ykkco5bv7xZgSA=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=R6VXbhArAIL0nOd/yzjC2LPNaSBbJVh1MqyuEm2Td41KdiWTRmLdfz5jIaAYerCb9
	 v/mSewLO0bPVocrhhm1aJmH1OHW2vInZTnvK0O1NOzDmNX85C/6/eYyOi4xiLpq5ZU
	 02Cc/N9DTkm2xyiN0UbkjPPit3lnwQWk9iVn9O19STk22WRTu8QXh+MrjBHIYBPzCh
	 GVQgvokZ17V3vLBFo4kAO8A/g0q53cY68Jt40b2nOJkKihS1bWVzRQFYEOPJ1h7BKj
	 tDY9mWasrp5ghGJp7hELvIJA6s2IXPVtq2TuThQDtheBiVnbP0ZtgUCCl/xS3jrK2A
	 OPHLUNggY4RQA==
Message-ID: <d5d90f03-3db8-4f90-baad-0be4f3d3e0ea@kernel.org>
Date: Mon, 24 Feb 2025 11:15:23 +0100
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
Subject: Re: [PATCH v9 2/3] reset: aspeed: register AST2700 reset auxiliary
 bus device
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
 <20250224095506.2047064-3-ryan_chen@aspeedtech.com>
 <71cf8012-3b77-43de-b8ac-54c84a97f9d3@kernel.org>
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
In-Reply-To: <71cf8012-3b77-43de-b8ac-54c84a97f9d3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/02/2025 11:12, Krzysztof Kozlowski wrote:
> On 24/02/2025 10:55, Ryan Chen wrote:
>> +
>> +static void aspeed_reset_unregister_adev(void *_adev)
>> +{
>> +	struct auxiliary_device *adev = _adev;
>> +
>> +	auxiliary_device_delete(adev);
>> +	auxiliary_device_uninit(adev);
>> +}
>> +
>> +static void aspeed_reset_adev_release(struct device *dev)
>> +{
>> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
>> +
>> +	kfree(adev);
>> +}
>> +
> 
> Every exported function *must* have kerneldoc.
> 
>> +int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
>> +				     const char *adev_name)
>> +{
>> +	struct auxiliary_device *adev;
>> +	int ret;
>> +
>> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
>> +	if (!adev)
>> +		return -ENOMEM;
>> +
>> +	adev->name = adev_name;
>> +	adev->dev.parent = clk_dev;
>> +	adev->dev.release = aspeed_reset_adev_release;
>> +	adev->id = 666u;
>> +
>> +	ret = auxiliary_device_init(adev);
>> +	if (ret) {
>> +		kfree(adev);
>> +		return ret;
>> +	}
>> +
>> +	ret = auxiliary_device_add(adev);
>> +	if (ret) {
>> +		auxiliary_device_uninit(adev);
>> +		return ret;
>> +	}
>> +
>> +	adev->dev.platform_data = (__force void *)base;
>> +
>> +	return devm_add_action_or_reset(clk_dev, aspeed_reset_unregister_adev, adev);
>> +}
>> +EXPORT_SYMBOL_GPL(aspeed_reset_controller_register);
> 
> No, you cannot export functions without users. There is no single user
> of this, so this is not justified at all.
My mistake, I missed patch #3 which uses it.

I don't get why do you need to export this in the first place, instead
of putting it in the clock driver, as usually expected. Handling child
creation is logically the task of the device having children, the
parent. Not the child.

Best regards,
Krzysztof

