Return-Path: <linux-aspeed+bounces-2527-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895B6CCD199
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 06:40:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqm5c0dR9z3000;
	Mon, 20 Oct 2025 17:40:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760942436;
	cv=none; b=B9rlLPSwAaJkNldNs3JJOPKK5TR/hojSbjB7FaCcNDxMrMIzF23MVv2eX+7DJobPAEVooTOIFyhk2mKVkz9ek/H40ffef4BD+GWKhhqZDC2jEB+jy6zgTnt5Gb75Id/3TqxF63RJJwQlzj3jMTi3xXprZDJOTov2FlvHWSLBbNT3B45HmFwvvhl9VLQNwUFTFs7gm7MHXCgGVTjnNJyxoYTD3WLaVgiD9UQmT/jUssj8dkB/Cr0s+ciwSR151UvjhuodusUnrEIqxjcICUbOWSreAtULlowN+Wzs4L8ACV7hmtJYZAO7x5ZnhuAVxJ2blWNX9OQqxLZAsYFGh/1RXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760942436; c=relaxed/relaxed;
	bh=Yx2JP7P7r2dszg72QONYsTzWX02D3Bj0Jaxh0gu3AXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S+Y8vrWGQ53VAt3QkpH7QZzTm+R7X96RR0W9dFWoW6iR+Lt36uBbg9gRu8uIU0EQcMlEEfhi3ZRXimabZXUQ6ItDEDBJn6bLDmBed2YAG+NnWjN5jHRH1fS2GobUhsdwscdEJp00nu329qnWOgINS004Z6aO/RJeEMLzD7JDNqF7jEcUomrRDrxO9GbAHp72AZT3zlpgKSn6WD4jfY27N3kZ/yxaZgBAEC+oh3QbWURmiFyBgLxbIbrGninR3PqBWE41u6i/5ojbDJBBeDFxt++wC8GN8TRK1zWYntmWNLt9OiRhsZWeb9PHB4/Wn6DoyC95AQcgJI0ZzHTaCFvrMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BpT25Pxe; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BpT25Pxe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqm5Z4hNhz2yVP
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 17:40:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 487E460289;
	Mon, 20 Oct 2025 06:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9787FC4CEF9;
	Mon, 20 Oct 2025 06:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760942432;
	bh=UJTlw/pu3vywNn13Ms+E5luWG1v4DvAhkTCP9OzzQOc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BpT25Pxe1mhGst83DZD9Z6TJ3ZHdU1xjdlaoh/Zf17hKKYEc+1Nf8GAb05LhVQ2Z7
	 FgtNhXTr4Q7WYA9muS0+V1kRjtizrKrvKBj7rfN31h6iyCmB7iUC5A+vle0G8m6YWf
	 jqVP5vI2ET3vRrE3hjXsZB3LwzqUCAGtXkdvA7jRwlLmvL2rQy1SlchjqsI/aR6hSp
	 D8sr/01r83oweAJBJeWDaSCuII4fZSdtem+jk0QH1qPdD9IfrGY2tdxBs8wwUWl18Y
	 VxAhUgzVeHpfau1l5rJ+LJMcFG+7osVCsSDQ4evzrZlBzXg/9gY8Nv9Zc1IrwPm/pq
	 rhsieA9VGUwRw==
Message-ID: <2eb2d833-03e0-4570-8979-3a28d708b21f@kernel.org>
Date: Mon, 20 Oct 2025 08:40:23 +0200
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
Subject: Re: [PATCH v5 0/5] Introduce ASPEED AST2700 BMC SoC
To: Ryan Chen <ryan_chen@aspeedtech.com>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Taniya Das <quic_tdas@quicinc.com>,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Eric Biggers <ebiggers@google.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "soc@lists.linux.dev" <soc@lists.linux.dev>, Mo Elbadry
 <elbadrym@google.com>, Rom Lemarchand <romlem@google.com>,
 William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>,
 "wthai@nvidia.com" <wthai@nvidia.com>, "leohu@nvidia.com"
 <leohu@nvidia.com>, "dkodihalli@nvidia.com" <dkodihalli@nvidia.com>,
 "spuranik@nvidia.com" <spuranik@nvidia.com>
References: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
 <41705e13-c61d-4249-9492-b83f1371d3f9@app.fastmail.com>
 <OS8PR06MB7541AEC5560E3445C33009BEF21FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <OS8PR06MB7541AEC5560E3445C33009BEF21FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2025 10:00, Ryan Chen wrote:
>> Subject: Re: [PATCH v5 0/5] Introduce ASPEED AST2700 BMC SoC
>>
>> On Mon, Sep 1, 2025, at 05:13, Ryan Chen wrote:
>>> This introduces initial support for the Aspeed AST2700 SoC and the
>>> AST2700 Evaluation Board (EVB) to the Linux kernel. The AST27XX is the
>>> 8th generation Baseboard Management Controller (BMC) SoC from Aspeed,
>>> featuring improved performance, enhanced security, and expanded I/O
>>> capabilities compared to previous generations.
>>>
>>> AST27XX SOC Family
>>>  - https://www.aspeedtech.com/server_ast2700/
>>>  - https://www.aspeedtech.com/server_ast2720/
>>>  - https://www.aspeedtech.com/server_ast2750/
>>
>> Hi Ryan,
>>
>> Thanks for you submission earlier. I see that you had sent the series to several
>> lists including soc@lists.linux.dev, which is what I use to keep track of patches
>> that have been successfully reviewed and that are ready to be merged through
>> the soc tree.
>>
>> Unless you have been told to send it here by Joel and Andrew, I assume that
>> they will pick up the series through the "bmc"
>> tree once they are happy with it like they do with the 32-bit Aspeed SoC
>> (ast24xx/25xx/26xx) patches, and I have dropped the series from
>> https://patchwork.kernel.org/project/linux-soc
>> now.
>>
>> For future submission, please send the patches only "to"
>> them, with the other people in the "cc" field to avoid this confusion, and leave
>> out the "soc@lists.linux.dev"
>> recipient. You can add me as arnd@arndb.de to the Cc list for reviews though.
>>
>> Please also add a patch that changes the MAINTAINERS entry to reflect the
>> added arch/arm64 contents.
>>
>>      Arnd
> 
> Hello Arnd,
> 	Thanks your notify. I will remove soc@lists.linux.dev, in next patch.


No, this patchset still has known (reported) warnings/bugs, which need
to be addressed here before merging it.

Best regards,
Krzysztof

