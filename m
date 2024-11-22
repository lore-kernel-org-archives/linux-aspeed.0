Return-Path: <linux-aspeed+bounces-169-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E5DE65D0B
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 Nov 2024 00:57:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XvcBb4ZXlz2xQD;
	Fri, 22 Nov 2024 11:57:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732237031;
	cv=none; b=chzekLEi4BeO69UGK7jg+tHJ5LnBg3GAOHkY+y8ugpKlaGCkyu0a0/3hmB2Idhm1mHBS2Hu7DqqmT/NgIg0Jl1wc8WzXHefMC6lhrVp7hkWERx383JDtGTcESJAKnoPnkzT0N40bBlkOUFtEhQMRzv3GYZHOHEs4/KlPlQHC8jZNTjtpwNiI55V6Pw8Ie8OzJNX9Wf68ruDYYIjhbOBCm2i9mBhv3IRB4vP55ERst7vAwueCWV/mBw+k1+6EGr+12rJpvG0c7wk5iKc88VNc98NRo32grXsEZZFGjr1nE8lhilDsq5sywvMjWp2BVIvda0X8worj/8ZxSuL5Po0npg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732237031; c=relaxed/relaxed;
	bh=NoFHxlk/MxXl8zn0QsJEzFEW9uJPQ9u0jXpK1xuLvzU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+sh9D2GNUpTnaC2IDNgVQRLThFif+NargBOJ6XMvgkh88zfWedE8kjLw3AZUThm6LTmqdkThyzI21yAUSo5nZSHSHwvMnfJkInUNdlcX05gJtUb/MYZwS7wXvLo0tu/jur0kva54xUd/Deh02B4NTTOwm+zY1usmbBf9M9O3aIgE+tDOZfcyRq3CCTYYKOPCf1BNFXvvABaDweK3a+aPPLh6GOovPkZoVghRZM9czk2wGO1Q4PqdbkfGZGKyZVFZuOutW7JRkPjHJYlE9/mqlw1F6e1LOdnN0XuTysEfizP3vAFvgVYbL80Q0BgXUWzbv0jYnn2cPmnYOFtFVloJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FIL2dtlr; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FIL2dtlr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XvcBZ60ZVz2xKg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 Nov 2024 11:57:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1732237030;
	bh=NoFHxlk/MxXl8zn0QsJEzFEW9uJPQ9u0jXpK1xuLvzU=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=FIL2dtlr7AuN89P3H/wj7W1MsXCkQvugxo0jOhi4kklYgD9YIbu552Ex6Wfk8ZIKD
	 j5tJJVKYcWGfxsKqHUJgJ3imk/K0OGO89bgnwrC2ORok8EbuTr+/vTe62yRfrv5PLv
	 nXtCr6yPUsf4BiMbLY0E04ZUXNpwVqgRnrjEye8MkCkQS3rz7mU+SAUj4V7JQETGXF
	 FNoCvU3y8Ial9m8D1vR1i9Uto7k8V6B96uvWvMc/mUGPDdIevtH7U/3VZ8E67Kbe5B
	 B9HIIrIT1PJTnG+9GjZMbGAA8blAVN28WlJAeEgg6VMN2UUd5EumuMzpgE3RayKKK+
	 s6NMQqjS+VKvA==
Received: from [192.168.68.112] (ppp118-210-73-187.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.187])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8C22268F88;
	Fri, 22 Nov 2024 08:57:09 +0800 (AWST)
Message-ID: <920e053a17d5f9a7d5805bcd674f036a9c7fb402.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/6] Revise Meta(Facebook) Harma BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: PeterYin <peteryin.openbmc@gmail.com>, Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 22 Nov 2024 11:27:08 +1030
In-Reply-To: <b13e5063-3b07-43ec-a7cc-b19e73b7c9e0@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
	 <b13e5063-3b07-43ec-a7cc-b19e73b7c9e0@gmail.com>
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

Hi Peter,

On Thu, 2024-11-21 at 12:33 +0800, PeterYin wrote:
> Hi Andrew,
> =C2=A0=C2=A0 I believe this series' path will conflict with upstream due =
to=20
> version differences between OpenBMC and upstream. I will update to
> the=20
> latest version of the DTS from upstream and submit a new version=20
> accordingly.

Going forward, please make sure that patches you send upstream have
been tested on upstream (in terms of whether they apply to the
appropriate branch, and whether they have the right effect on the
system at runtime).

Andrew

