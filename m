Return-Path: <linux-aspeed+bounces-966-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D51C282DE
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Mar 2025 07:15:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZB7TP1Zj9z30Wg;
	Mon, 10 Mar 2025 18:15:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741590935;
	cv=none; b=duSR7mEzh8KAhRNmkeVtrYMPBhtTyq6RfVAay8oPaw/gSvTyctBIPIxHAQIQIEGOeHKOpnoHXZKz9tFkjuaJVA8dDI7MuUJt68HSSKpYXoAqd1021iNeeumQ7AyExgkL6/l14btujsdB1iH147hL4JBDEPyGaICBGYP65xq4/TAEoD1lMdN88x/BJKETnaca+bd4QnPrKCRFYitaA11xsiihSp38JAE07DoELGlUcBUrypRdNXFWZnqp8Mm9C/8BDF4+1AVpBkrWC1ixM80Dszn6Mz832Z5MFkus5CzAxcfAALoFy0A62hB3Xa3Ej/DSvoXp4J1nUje6kyRqvoVkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741590935; c=relaxed/relaxed;
	bh=nmX1iL3qpmbogVVHnu/MnRZvWEW+NTxzPDubCw3/6Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PiTdMJC9Q6o9oSSAwh7elphC1VAWanJaipH6EjQp0RguINvcwzNp3w6bES8QCp2NxY1olajccEplvzY9GJKH4maCuqcmw8dGljV0ZqTYsKRK2ZM4MC80LGGQCDYFjlg2etY8sgJNQP16Cxc/lojKgBtwZrIK86iadj6oF0NsRiL07T1YyBFRes6881hQ3lgMiumPQ7iu+TFZzCjs2DcR7akoNWAaQTY3/5u9zKz6mnJrMlkf6gWJ7vkVMemiZ+Y/8LKMzLemV2WMfXcCW6NYf4GgA41L4ksTDyuvHQaOVfBLa7NWGWTd8MjwbB/KO217+reZiOhCdYt6wRhzzamC/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rl4jWlx1; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rl4jWlx1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZB7TL5bvKz30TQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Mar 2025 18:15:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C5F81A44BC0;
	Mon, 10 Mar 2025 07:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E459C4CEE5;
	Mon, 10 Mar 2025 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741590928;
	bh=ukmBN1EwaxLenjYh9LRHAQi25Riq9TJLf4Rh32znRWU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rl4jWlx14Ui4SWBpbVbkusbb+1KD/CyraNvvMNlQlfm4Sj/MOtaBNFQPYaH5dB9md
	 jxIJPpsvvAE/S01SPXxL1y8id2UyEV1ZNhmtM53lREI+QO6YWDq2j64n60VN2ccWxr
	 kbLbBmB/aDtZoOydQBiEWQYPrIYp3mhIER0pjvpVswumtc/RaSMvYJ8bvO1jLVidcY
	 tgw3SAp/96nUKGSwpZg8RSMH2CgDXQVx4rOwWRYk16LsMjd2nfDL8OhUFYe8eXR2Tb
	 b917+Am92yndoTxAjoHULvNcsmbp9uybDjhnEyQAryiXItGPSNG2ZrCcAJcMyC20HV
	 Dcqp7Gb3lM9pA==
Message-ID: <e17cdf9d-ba96-41d2-9656-9e50d0e0795a@kernel.org>
Date: Mon, 10 Mar 2025 08:15:20 +0100
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
Subject: Re: [PATCH v2 1/3] dt-binding: aspeed: Add LPC PCC controller
To: Kevin Chen <kevin_chen@aspeedtech.com>, "lee@kernel.org"
 <lee@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "derek.kiernan@amd.com"
 <derek.kiernan@amd.com>, "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mo Elbadry <elbadrym@google.com>
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-2-kevin_chen@aspeedtech.com>
 <8740eeb8-9467-48bb-a911-e70c3da3c45a@kernel.org>
 <PSAPR06MB494973DC08A8105EA05FBE6D89D62@PSAPR06MB4949.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <PSAPR06MB494973DC08A8105EA05FBE6D89D62@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2025 02:50, Kevin Chen wrote:
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +        description: The LPC I/O ports to pcc
>>
>> Description is too vague. Why would we encode I/O ports as some numbers
>> instead of GPIOs for example? If these are ports, why this is not a graph?
> For the port-mmaped I/O in x80 architecture, BMC need to handle specific port I/O in the relative HW module.
> So, I need to add the pcc-ports property as the snoop-ports property in Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> 
>>
>> Missing constraints - min/maxItems, defaults, minimum/maximum etc.
> The port-mmaped I/O is defined from host, BMC as the device would capture the port I/O from the pcc-ports property defined in dts.

Put this information in the description, instead of copying property name.

> 
>>
>>> +
>>> +    required:
>>> +      - compatible
>>> +      - interrupts
>>> +      - pcc-ports
>>> +
>>>    "^uart-routing@[0-9a-f]+$":
>>>      $ref: /schemas/soc/aspeed/uart-routing.yaml#
>>>      description: The UART routing control under LPC register space @@
>>> -176,6 +205,13 @@ examples:
>>>          #size-cells = <1>;
>>>          ranges = <0x0 0x1e789000 0x1000>;
>>>
>>> +        lpc_pcc: lpc-pcc@0 {
>>> +            compatible = "aspeed,ast2600-lpc-pcc";
>>> +            reg = <0x0 0x140>;
>>> +            interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>>> +            pcc-ports = <0x80>;
>>
>> So what 0x80 stands for?
> Host as x86 architecture would access the 0x80 port, which is mapped to the BMC PCC HW module.
> As a result, x86 can keep the port-mmaped I/O usage and access the BMC device, which is needed to know which port using in the PCC module in BMC.

And on different boards this is not 0x80?

Best regards,
Krzysztof

