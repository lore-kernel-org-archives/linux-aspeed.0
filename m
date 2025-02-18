Return-Path: <linux-aspeed+bounces-762-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C056C021A9
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Feb 2025 01:09:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxhJb1bjcz2yFQ;
	Tue, 18 Feb 2025 12:09:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739840991;
	cv=none; b=QDjstDmnjaKnw4gG73SnbtDLfzZeDEMeJhfkxoRTJCp9dla9uSwlMG24fvMIzyzEXxGZ8G350bQgKEiQMGf/EPKwT5OlQl+NXUE/mulL1K2qKSU33D62sy7yfyU2SO8Nr0W4/H0IH1PeDfsukTJZHFdk0codDNjWywEgJQFRtRrYZF3vH4o1rUFvpC31+qnqQJJqxKxXW3GLGeGdZFgesErsONeYzmYyPlYdLfMEYGVTVKTdly1FNM8q3kcjKhSCCEAXUYRHl107HB2VinAr6uuIuAwf/LO8TpLdvOVH5Cx8QVoOrFbNAEJ8G01FVf3IUoHk8JKCt7pcCZyYDjAbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739840991; c=relaxed/relaxed;
	bh=42hWqZkaDlwsbOuKcR363GQ3gUU+QNYqERbd6QgQwlc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k6wCZ9oLPdjp+Xo00w3iOTrVqVCTquuM+dJjRiStprZO5Fy2c8xhMTPZDCJh77j9ifEwn7R2vsFayXQyT9Kv/utyQVMmaI/KALlSiXyurv72y9rvH2bpghw5IjS4h39wt/FB2Hgu805DF67xxBoVcojfx2JQ+p7ftGeLZ4fz97gz+3S7ifxm1ZYnM/IaKim3OPtimsniymJfU79IZx+drQxb+9+noTsDmX5OJSXgSgwedD3ccaFefaXvUWJIaRU7L/3MnK1/JT63N4TXp9cPjZefDGx1L7WkQt1Zsco5/7iwLJn8muN7Y/jIZJANwMd0AVKKkJxkhkMuoqGJzS0w2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MR++2k7U; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MR++2k7U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxhJZ3lvLz2yDr;
	Tue, 18 Feb 2025 12:09:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739840990;
	bh=42hWqZkaDlwsbOuKcR363GQ3gUU+QNYqERbd6QgQwlc=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=MR++2k7U+SQKF98nYBZwOBmOb2ncRe5qVWZZqcgx53Sxw3D5moRDfFaVkaHQo5NQ4
	 LbioIN1E+rcU4Wp1Hu0I4t8thOoIhVZbPzjXj93GiVOal9l27Ela+cMaKBpmCu7kJn
	 XwTfFf2rQDw6bw/3mh2fjTHBnkkNRx2UVhb/c+dhq9l6ez8P07OmspidVXdrYefeG3
	 Y+g5frhVzF8OswBMD88vkDH54VcxI7BDmHRh7iroxNDAcLKcpqMTdUkK+83LSo9H64
	 6NO4s475K8i/MJC9vvAQw0dmtxeDxdFCo+I+orlHbkbg9svQ5Orna6hLHx+edN52nm
	 Ra+qldThpmp1g==
Received: from [192.168.68.112] (ppp118-210-165-49.adl-adc-lon-bras34.tpg.internode.on.net [118.210.165.49])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1E5A876234;
	Tue, 18 Feb 2025 09:09:49 +0800 (AWST)
Message-ID: <560da647d1fd12c53f6403db4207fec48899648e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] media: dt-bindings: aspeed,video-engine: Convert to
 json schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jammy Huang <jammy_huang@aspeedtech.com>, eajames@linux.ibm.com, 
 mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org,  joel@jms.id.au, andrew@aj.id.au,
 linux-media@vger.kernel.org,  openbmc@lists.ozlabs.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 11:39:48 +1030
In-Reply-To: <20250213015338.3243171-1-jammy_huang@aspeedtech.com>
References: <20250213015338.3243171-1-jammy_huang@aspeedtech.com>
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

On Thu, 2025-02-13 at 09:53 +0800, Jammy Huang wrote:
> Convert aspeed-video.txt to yaml format.
> Update aspeed-video.txt to aspeed,video-engine.yaml in MAINTAINER
> file.
>=20
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks Jammy.

Andrew

