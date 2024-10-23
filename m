Return-Path: <linux-aspeed+bounces-19-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6596BD0BB46
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Oct 2024 23:42:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XYlvx0Nbgz2yhD;
	Thu, 24 Oct 2024 10:42:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729726956;
	cv=none; b=K8nimaevVwIWQBsAN/fPfTtR0kDRc7b7p056iGPpyJzQVWuq98oOSOe5qv/JClF1Wq+aRXS2cV0ynd1687eDAiOE+4x76rJ10PvLGyeu8yI7pq9yG/R8u0ZnaWQNi0X9vxvLVAKf6dPuQCsLmvVijtCNBuBbx+jCTGj12K9ptWKrGixVlRPozzQCpzUkooDVotpwLQtstPjaJizHGsrt3IMVsxdN+CHZdStkazCXtX+AqZWz5YIVGwFrnhkrA96CQgTwzswLEQyvAGpCXnHo2x8gPeiH3g59zqcq5NlduFKOmOdKN581LTDQVCNF5B3Yjw5QKJFKlf2PO3hkqKOFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729726956; c=relaxed/relaxed;
	bh=BI6v3yvMOxexD3sSG5ohKly6PqVC6npk+POPlf5PUAE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXXUXjAsQFDX0BqHMEJJZikdr+LAECSvzmP3aHsvx97L6Xox1elFkMYkEQh81cQ8T1N24glkJe/ycy/GT7c8xUyJn7Y9R8wWFqCyddWjUsNep5eL3Lucq2L6O280VfXlRQ3Cyev1BTVbkTngmUG6k6PqdOFDsdvP3CHE5zp+xkFyaEpgVKn3mnf9oJKahx45QYetF1CnDAxFVr276wMiD77E5iuTyMIEjx5cCLHt2VtfFdh5XjzovGEpU/hB//EITWHMep+WLPMtdXrvB3hfQVKIvxP78ypjFrc+gVNgo53Zo19wQQxAuPwDVNHT5vVIsN/svaP5KPdnb7uZmghCVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=C6TuwGi+; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=C6TuwGi+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XYlvv1pMhz2y8d;
	Thu, 24 Oct 2024 10:42:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729726953;
	bh=BI6v3yvMOxexD3sSG5ohKly6PqVC6npk+POPlf5PUAE=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=C6TuwGi+JuUDnThIMHcYfPM5VI3p40hN4IiRDyJfTzJUfUIeZt8tfLzWKK1QgMuD9
	 IdW88uxyoXan2U6yyhOcT+smXUXf7+v2s47kGuJ97r0Tn6zZFuLTGk7q5lqEZBaWdg
	 FGSUsg7UIHHz6cg4CvwE5q9KpIXPB8yKvzrSpf4XkNpSI1ToYFBQKyXF/f0Oss4rED
	 cxEO9uBgfoncQ9IRHEHCsoanag4T8x9/f9dovX7tcLULAphXD4Cp51ozAe59apxXPj
	 p5gHEc+LRApwAPvxJGx15Bl7kVrBAnErvsQh8q+VRMC0+iKP0olsOLHZY0xO8YrQOB
	 IGuOD3gCaJr3A==
Received: from [192.168.68.112] (ppp118-210-190-208.adl-adc-lon-bras34.tpg.internode.on.net [118.210.190.208])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 030B16494E;
	Thu, 24 Oct 2024 07:42:31 +0800 (AWST)
Message-ID: <f60e70982efbc3d1ea3379b0036b25c74f953411.camel@codeconstruct.com.au>
Subject: Re: [PATCH] pinctrl: aspeed-g6: Support drive-strength for GPIOF/G
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Billy Tsai <billy_tsai@aspeedtech.com>, linus.walleij@linaro.org, 
	joel@jms.id.au, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 24 Oct 2024 10:12:16 +1030
In-Reply-To: <20241023104406.4083460-1-billy_tsai@aspeedtech.com>
References: <20241023104406.4083460-1-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 18:44 +0800, Billy Tsai wrote:
> Add drive strength configuration support for GPIO F and G groups.
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


