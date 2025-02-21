Return-Path: <linux-aspeed+bounces-799-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4781C021B2
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Feb 2025 02:50:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzZPV620Xz30T1;
	Fri, 21 Feb 2025 13:50:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740106238;
	cv=none; b=JOUTNegVQa9h45UksSxVXS2RX2OJJqzz4gD33VP58R8X8wXHkZkoBCOG7htKipHN5X37EMa+SNUyZ64YrkkHmKgXJo1ovA62hSNXmZlLi6CFPph3HpuaMd+udHyyzJfsVGq9ELEERoUStCXoRvOdeM0P5MafPS21j7MQa1Eang6kcHBu0wEXnfjaGI+/s6o2gk2sNkhyRjWwwGapgwWB72DZ7CdeqLBtRdS2zna+URmhMDIrIJp5+c5o+9YwY7OmI8U2ONptY3cT87ncj4yMz/093Ad8JmRVTR3AZyIcLWczwVstj1E/flY/7YtbpJmjyw0nPteR+ixcjvgiL7NoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740106238; c=relaxed/relaxed;
	bh=UnJlIFv0UPUzNd+Vm3edQcV3c4YlHIanESgLP3djvo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BJAYBYp2zPTa2ZcXdXjrm2mRbNd1CGmNdmEBGWx4MH2FMnMy3bZrcD+MiIekDANVnOaN1HpcNZjWqqxnq8u9bCmwRKDayp3Y1MZrsrgEgTmYiGG1/f/Jf8JrOT8AoCivEVP4fh8Qw+E/mpFeVJFHN5wIqdBcGue6fe0MRCTDqxtkrSd2uqi4yK0XRpGb0bsAfe66CHUJMzxL2VznlksXLk7nUzlEdW7CQ4Xu/ncGtuixHl66tWHOJGB+yVB0NiF7gHCDSlG0VUQMeywQSyWuYcdnT+Ucqp/4D/Yn4NVWxZzpLa1K9rhkgDmBLBAwjXQRY9lixLwYY+LqNZQHEaBnzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bS3XDmJS; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bS3XDmJS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzZPR4KZKz2yyR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 13:50:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740106233;
	bh=UnJlIFv0UPUzNd+Vm3edQcV3c4YlHIanESgLP3djvo0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bS3XDmJSaRwxBcjtYnMTwIb+H/BxFKEtm3Pk7VaDsbV19owr6Q+j1opLuCdtqhQjD
	 6+dx3TMF4X+YLGT3ur3e/AynpgFoaPBP+vI223VEgbjjCuBxhzUe2/vHDgY8UUS0cH
	 tpBvqc2ZQBtmnsdWHuqYkOS0I56/E++xdqSsN1+TrdBmEqzThNE3Mt9bOaUCZdn5W/
	 WdhUezPTM4PI7OoUGenB05aasczV9qn3O4nKodwZiLdtHvP0rDpANhShljodZzXkja
	 OkbLOh5h3ULoqcIbv8eNIuBjrOS2om0ynANUpLZCNQDTt2xg1fj4v7QJ7m0hoFy9Ec
	 7ljKn+ys0IO6Q==
Received: from [192.168.53.88] (ppp118-210-81-188.adl-adc-lon-bras32.tpg.internode.on.net [118.210.81.188])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 59BAE76B4D;
	Fri, 21 Feb 2025 10:50:29 +0800 (AWST)
Message-ID: <eec1e53185baeed99e5e0c86875f121ab4d25fd1.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5] ARM: dts: aspeed: yosemite4: add I3C config in DTS
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 21 Feb 2025 13:20:28 +1030
In-Reply-To: <20250220023233.1686419-1-delphine_cc_chiu@wiwynn.com>
References: <20250220023233.1686419-1-delphine_cc_chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

Hi,

On Thu, 2025-02-20 at 10:32 +0800, Delphine CC Chiu wrote:
> From: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>

Typically git's user.name config should reflect your well-known name
(with spaces between your individual names, and without e.g. a -wiwynn
suffix).

>=20
> Set I3C config in yosemite4 DTS.
>=20
> Test plan:
> Tested PLDM GetTID successfully with the I3C hub driver.

How was this successful? Your patch fails to build on top of v6.14-rc1.

Please make sure you're testing against an upstream kernel tree.

Andrew

