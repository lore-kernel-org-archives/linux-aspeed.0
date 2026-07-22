Return-Path: <linux-aspeed+bounces-4534-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8595C44539
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 13:16:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4vsg1fTpz2y8p;
	Wed, 22 Jul 2026 23:16:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784725715;
	cv=none; b=obMQhON+nA1/2pf/qahlbt2rP/52ajXs66O3rhp5c0aqVd31BNGAEJOo5GacXRrPcjE9oTtxzAfhqDy5YCZRmmcQE6fva9JRJ5eqQ7y4s+3u2l9pUF2nNNyx2/IN3+/2y6xSXL/5ji6gsPJ0LBf6ZSUf7GsPZy8z+n7Ya/QspytgOhb/ItqykvhV7lDp8Z3Op6xcuZTjJkFmvKnO3ontlxu61Ihei9UYR4WnQlegXfo4ZjGdjT2VldVhg4E2knofcE9ZlfZjXOI0zSq7J0H/aX6EGl4UI3TeVfpE4Fr1xq+Vw5aSsAz0r8QTnk47hQsjY4bwpDE2wsMtR/7VJZySSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784725715; c=relaxed/relaxed;
	bh=WaPDbwxCsdcx+B/dCejKtJh2wWTua00Ci6Hpi0ul8C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMHSri3Hp4s3GAZ/NHkAreCc0zK0rD9TvAOtCD8spBCqzFdOvI9+fxmMGLO5Sg+A8R4ke/85Z08PWN9GGSTu0Ll2+9GFTgGOXbtkxXnni+Q4s1ZrV/JbyYKYCIWrVdETH1XjF4BSguoQlMX+lPRoyvXl2Kl6TRyMyhiywsUrAgM2GyoVCJeWFYMaVVjqCR3Sh+eWAHvFtygHfz0pW1w1vfy7iEhFFy8WkDMV0jA2oHPDEaue5MCk+uIQBGmoVnKkbES5yIuBcFeQIypn3vpkDSOfay/LEJAQCwSDxkk0kj1yFGg0SpqYxpZflqQot+1bsRlzHh/i6AelBVOfqGHO6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=H7xCUMUY; dkim-atps=neutral; spf=pass (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=H7xCUMUY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4vhH4B3mz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 23:08:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=WaPDbwxCsdcx+B/dCejKtJh2wWTua00Ci6Hpi0ul8C8=;
	b=H7xCUMUYc/LooIzd+CSV4M98TEu1QIbG+rVULphn8ypPW3Ek4oRmPTSrR0BTeb
	oJ+jvvyj4Tvlx9myhIVE9GLwTQWXpVxr5nJrn1A21G2Dn6DGGBvLvBJ2ndJevJxe
	bOKiqmNQ83H0B5Z0k83upy/IwqMDvMgOipJcBqsqzaTH0=
Received: from [192.168.1.104] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCndQKNwGBqqIFOHw--.52029S2;
	Wed, 22 Jul 2026 21:07:26 +0800 (CST)
Message-ID: <c85229c4-2c9c-4231-b294-e8012c3fead6@163.com>
Date: Wed, 22 Jul 2026 21:07:23 +0800
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
Subject: Re: [PATCH v1] ARM: dts: aspeed: g6: Use KCS AST2600 compatible
 string
To: Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 "moderated list:ARM/ASPEED MACHINE SUPPORT"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/ASPEED MACHINE SUPPORT" <linux-aspeed@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260627052708.172918-1-haiyuewa@163.com>
 <5333a3912656d4c85fd063dc5726106e38150ad6.camel@codeconstruct.com.au>
Content-Language: en-US
From: Haiyue Wang <haiyuewa@163.com>
In-Reply-To: <5333a3912656d4c85fd063dc5726106e38150ad6.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgCndQKNwGBqqIFOHw--.52029S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjVbkUUUUU
X-Originating-IP: [101.228.92.86]
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbCzQ4GcWpgwI7TFAAA33



On 7/22/2026 8:55 PM, Andrew Jeffery wrote:
> On Sat, 2026-06-27 at 13:27 +0800, Haiyue Wang wrote:
>> As the commit 2596f6b93a60 ("ipmi: kcs: aspeed: Add AST2600 compatible
>> string") does, change the AST2600 DTS file to use kcs ast2600 compatible
>> string.
> 
> Is there some other motivation? It's been a while, why now?
> 

Just happened to see 'ast2500' when adding other nodes in DTS. Nothing 
special.

BR,
Haiyue

> Andrew


