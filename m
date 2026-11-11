Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6B606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=POJCMNyn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPQkw439Nz2yDD;
	Wed, 11 Nov 2026 12:23:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794360200;
	cv=none; b=EdDT9Tpzn/Mggv/4NVSqWbWW44jNQ6r5mWpv19JbTjGfMmozl6YqzGV57c1unW9zwWv4e/sOcXbTGOMmUsa5De5G3QNNxVEHOSAfq40O59lh39iTSWSY0NOqvizJDFtymLRLV2qT0778hQA/3foZZxeIzolu3cnp1egkpohBNgKbhpKpE5dflTTTXvjqWBdPJ1O7KJcmFDRliSPoP4eglju/3QZ/ckbn/kAdOvnXZ6cRfSuFAtjIHO2JVfC9Wxlv/62gWKONWSyZdH1dbY5p6jJZSfDL8Af0xHDeo0299TSJ7aUHv6kpt5EAidFNK09valJa9iZ/jUW6pLVF/Gq0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794360200; c=relaxed/relaxed;
	bh=me/uMZLei5JIMqJLLPA+JNTv7cc5G55ohXwpfueBK1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJlsHHTm1UT0GchWF03g8/6wk6lqEE0O0ZkblpwP1V3SWDFzK8z0dfVUyUiu/uwFMcQUjwBZEf1Gg8laonCWU+m6EbOvhkmNNUbRFcRIvAfjHQktTxXUmu//G1IjO5B9PckUF+mORmQ5zyrbBlI/FMfrvb1jvlYK9ZSOKb38P9oKuIChc1cbRZXWeycpfdCw7aD5TtO+5Gir6IqVC/Lzb5MByiGyyloWy2l5Sn/sYv3V0EjbuSeVis5+crNixaVVj4oJkF3Q0oeHlcud1zCn2i3AIDP47t4mxszF7v+LFwm/BETUjj+UKSpV4v5B87UnBvXhIoAdzw41NYq8Brv6ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=POJCMNyn; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=POJCMNyn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPQkw0wkYz2xM9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 12:23:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794360199;
	bh=me/uMZLei5JIMqJLLPA+JNTv7cc5G55ohXwpfueBK1Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=POJCMNyn6snlb4G0e2HDTHoPRzRUBxoRk8jFatnDEtPv1p2ZhwYVCI5L5Vp9rcBwr
	 PkhiIN366ux6Ed1P4CIyu46MRmf7nbpmJjF9vEK1cAMwWyTYigfD6OnYaKyfb+uEuP
	 jdqWh1ZQmmwWM084HKuZUwuLmqzF6oDJKHFCTmA4erFENMjLjtZ1SRd1hkpvl36M/4
	 W4xI9Rh0DZSxbCFdMfUav/0Hof5XgXq7kXMRLCZCuQXgyUh+PJ2T3YCHXBCajW0/55
	 U3xHPNdpJBZJ8L3tBNv97CHR+DOZAPcy4587TXhp9dNrmq6+e9TRSrbfKVp3ie3oaa
	 U7G9f7qERxmiQ==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2B90D64C3C;
	Wed, 11 Nov 2026 09:23:19 +0800 (AWST)
Message-ID: <8b78ad45a331231c0dc0d6b459d2bfada521b6f0.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: anacapa: remove unused EEPROM
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Carl Lee <carl.lee@amd.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>,  Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	colin.huang2@amd.com
Date: Wed, 11 Nov 2026 11:53:18 +1030
In-Reply-To: <20261110-arm-dts-aspeed-anacapa-remove-unused-eeprom-v1-1-e3b5d9cc1a03@amd.com>
References: 
	<20261110-arm-dts-aspeed-anacapa-remove-unused-eeprom-v1-1-e3b5d9cc1a03@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Carl,

On Tue, 2026-11-10 at 17:44 +0800, Carl Lee wrote:
> Remove the unused HPM board ID FRU EEPROM (0x51) from
> the I2C mux channel 4 device tree node.

This is evident from the patch so in my opinion can be removed.

>=20
> The EEPROM is no longer needed in the Anacapa device tree.

Can you please explain why that is in the commit message?

Thanks,

Andrew

