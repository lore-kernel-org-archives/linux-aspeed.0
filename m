Return-Path: <linux-aspeed+bounces-1014-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAA2C282EC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 13:21:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGbGk6K6bz2ydQ;
	Tue, 18 Mar 2025 00:21:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742217710;
	cv=none; b=mww01IAfMSYusGceCcttC9FxTtoruQbcNqWad22Mc9hWyMFa3rCYdm16h02n7KW1BSW3LiRfTpqcxQKDZETUPwA105GhnaA8Gf8Z+K8caPKSkv514N8wI9Lpi6O0aDlcSdCsUio9AnNu1epIkPc65diZbJUfjv9GDyt5Sxs93ShZJDt+xdR395d37F+St/oaT2DGeeJQAJL8gFuXTyf/XcRp6u/DWizb4YPAo8huD/4iTgEpkPijqHpRvJIWs+K1m2EMY5agOx+uoOaUihPG6+zWmHKwNdaONbC+EoN/YyNA9pNQ6ncgDEOAPUD5LUp05Ql034K7g8THVMLgcvfaow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742217710; c=relaxed/relaxed;
	bh=SopKbaAEcFY5aGjdVyQpifHLGLQWge028oU76LBh0fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chyxLvDvYVnIpFGt4qYMhBEjQ7AHzs3IyvKKJ3YmNG2eC31Bk11BY0/1J+dSN7pbBI05stMUhuLzFFu4TaVuy8n4KAi3Of19mhJIVwZ6muZVgThp0vfqDDNlqRd3IDYVMcwSgupgfOOe+L0CuaX1WcOfnmwthpv2cVBQD5LeL5qQgKyvOTsA4PO6s++qp8zFjHDT85sTrc6wylqyuv8471L+rxHkWnYL/vV2eLMTV5fvVS48k7k5OACwWCNYmyVmUqpe4JhrzUvPqec0/UpB2NOT0dM5fgdNFUiZLOZMZBkOr5vh6kD3ZLo1MIDCGtATfpkAwMXccrcmXvOVemeV1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xvfgdopu; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xvfgdopu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGbGk0PqGz2yGy
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 00:21:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3B1475C2705;
	Mon, 17 Mar 2025 13:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC67C4CEE3;
	Mon, 17 Mar 2025 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742217706;
	bh=Oc3lfjx/ijz4G/yinN5yn+L6EmluuqYn6RIuRZvGRks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XvfgdopuYdzytg17sbLWTaxx5pFyB6faD5/OFIR+iBQyFacZuurIZSLnV6HT4i7uT
	 gMtcudwzEY7Re1Igx03cdKgZrfDqhQXo1CQtQsgWqAEU3NgzSrQR+CE1oyD2NY0XFK
	 usw8qoxEQeZBE0jj3/Q4+P7zlSwXnBq2eSH/otAxqLf8HEP3aLlGWRbGCzc0a1Agbs
	 LacZxaX03E7TtF4AvMfgtNiq89KAsTbtO03l8a8fxpoZ0KbuS7ZO+aIHH0WVKDXuNU
	 2GEvetkARzXUYQFzVpfqpZz5EwGpoE9K8zYPgWqTFdXQp/GC3HY1A18cO/C5H/+mFa
	 S+4XoTjtQ04HQ==
Message-ID: <6f862344-b6c1-4c9b-a6d6-bb0e6655d16e@kernel.org>
Date: Mon, 17 Mar 2025 14:21:35 +0100
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
Subject: Re: [net-next 3/4] dt-bindings: net: ftgmac100: add rgmii delay
 properties
To: Andrew Lunn <andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Ryan Chen <ryan_chen@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 ratbert@faraday-tech.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 BMC-SW@aspeedtech.com
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-4-jacky_chou@aspeedtech.com>
 <27927166-d73b-4837-90a9-ed15661b0a6e@lunn.ch>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <27927166-d73b-4837-90a9-ed15661b0a6e@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2025 13:44, Andrew Lunn wrote:
>> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
>> index 55d6a8379025..c5904aa84e05 100644
>> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
>> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
>> @@ -66,6 +66,20 @@ properties:
>>      type: boolean
>>      deprecated: true
>>  
>> +  rx-internal-delay-ps:
>> +    description:
>> +       Setting this property to a non-zero number sets the RX internal delay
>> +       for the MAC. Use this property value as a index not a ps unit to
>> +       configure the corresponding delay register field. And the index range is
>> +       0 to 63.
> 
> You have to use picoseconds here. As with all DT binding, you use SI
> units, and the driver then converts them to whatever value you need to
> poke into the register.
Ykes, I did notice that when skimming through the patch. Such a sneaky
way to pretend you conform to the bindings but eh, not really, I will do
it my way.

I think reviewing Aspeed code takes a lot, a lot of our time. It's not
only about this patchset but several others.

Maybe it is time for Aspeed to perform intensive internal review, before
they post to the mailing lists? Several other companies do it, more or less.

Best regards,
Krzysztof

