Return-Path: <linux-aspeed+bounces-2310-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA7ACAC592
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 03:46:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVTZ73Y3sz301K;
	Mon, 22 Sep 2025 13:46:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758512815;
	cv=none; b=cCoJiWDqynaZ4mbxtz7b0uSSvjZ4RtzXgmI30vISa9bkkavpCCobts/sxclKzd/yR20CjDMTwsoBiqfWUC9SCosp0PDLsX+kBSEKcTy3Czx7j/qgNjbakwnsuPpNa8titbPrIXuq/682Wt9BPxQNB5QOy/Mck+745tZiHApgyBoVKq9bgqV/QOPdupVanVznFH7Vs2IPqZQP3vRF6DFbXz4FQFO2CmVWtAVZrA44t6YgykHSMz6ZGI1mINzbNb5dNiF+mPRoIn25sV9xJTJetcQR/n9RHuhVkYdmT1u3LC76+QeakA1mRyqqjMLkDVcjVwcqS5YktRqqAOQAziPX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758512815; c=relaxed/relaxed;
	bh=EtXkXi5o13UjPW6UOARCjRJLe7zqlxFB0MGqVZLUWZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWaxTtCZpVlBOsYkMG10XEyEbJvp2+11sN7tPR0ox827pE2FH8l5XQN/yUBcsOL16wuH1wuqajC0n+sH7xdNq8WJbz/TB6a58oijctXpJdBPFs2R5KiWi/ShAoDD/YvzQJFqEJeECQ8ok99gXl4PS8ib4RxjWvq14U4Nb4jiMnQ4sH0VoaQHSasHcI54c2cf3WXfULUZKhZdYkI+9U6PGzKzfJxsnI4Rl4/yylLPUNP+M5ekKkFpHMYFah10WWi2kM6D4bDVzSeDG5g4wJhHsaprFPdQdhviOTRKPyiE5jqN1dT/P507Hp03cx9tF3phrf+ZRU+scfMug+F4FMO+NQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aOu6QaNw; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aOu6QaNw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVTZ66DTnz2xdg
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 13:46:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758512812;
	bh=EtXkXi5o13UjPW6UOARCjRJLe7zqlxFB0MGqVZLUWZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aOu6QaNwOL26odufxNXWWzUx+1ysq8xlrCO4dzH1tkRNHX79EvWd28MgI8Z/o+Y1e
	 /wwVGYpCbWMZYELCuYWNo00YsjW0i+2TUcePSx1jW7VLc3485Izzj7YjBFHaQqw3lD
	 3wYsdfjdBgu2mwyIZbOSUTvOBbVV2duFivCLLXG64abcq9KuVwfMQ5E03+W8U2sptR
	 m5q5crdGqQu9xYn0T5TnG28j55mhq6aROjFW6C6r1OdBwe0sMNmxWMjypaPtRPL1dj
	 SvymFSAFCaM5V1EB4a2ELmvdbnUKdxdMvh1v25UTbTROM3EHS7s6BihIlD9wpSklTI
	 Z8h4yrArcVPQA==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D3FFD64755;
	Mon, 22 Sep 2025 11:46:49 +0800 (AWST)
Message-ID: <16281e86d3cf5c97fcb59e73472dc8edca50c484.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: clemente: add MCTP over I2C support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
	leo.jt.wang@fii-foxconn.com
Date: Mon, 22 Sep 2025 13:16:48 +0930
In-Reply-To: <20250918-leo-dts-transceiver-v1-1-3e2580325edc@gmail.com>
References: <20250918-leo-dts-transceiver-v1-1-3e2580325edc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

Hi Leo,

On Thu, 2025-09-18 at 17:43 +0800, Leo Wang wrote:
> Enable MCTP communication on the Meta Clemente BMC board:
>=20
> - Add an MCTP I2C controller node at address 0x10 on I2C0
> - Mark selected I2C mux channels as MCTP controllers
> - Remove unused "i2c-mux-idle-disconnect" properties

>=20
> This allows MCTP devices to be discovered and used for
> management communication on the Clemente platform.

This description covers details we can see in the patch itself. Can you
please rather describe the motivation and any related considerations,
e.g. answer:

 * What devices will you be managing via MCTP?
 * How do they affect the function of the platform?
    - Alternatively, how does _not_ having the MCTP capability to manage
      them impact the function of the platform?

The general advice provided here might be helpful:

https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es

Andrew

