Return-Path: <linux-aspeed+bounces-2483-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7442ACCD184
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 05:08:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cntBF58qjz2yrt;
	Fri, 17 Oct 2025 16:08:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760677685;
	cv=none; b=k7nGJFosxJHzf/HDB5cAr1JsieYpfLq5TgfbJu3kqTKaFYsRHc4ZHlQCcF9eKv2GCPqsYLWfcXIiaV7HV0WvsPYqGWTDpARn9VsdIl79OXS2nvhys2vwtU3TafE+0Yg5PVnKI4aCcSBmk63VsjylK947UmK+iXa4rK6FE9KsO8oY1qqPwq2vi2QOEOEzESCfxZulkrTJppnlZi55mZOY7po8fWcZkSpsym18S8H5rI8d7eSclQHBDlurVdA0YDDvW3v7fyGaKIVM0H2cFbxAG+04T7BR+RiVVgC2yBZGeVdAt8X+nDqo8Vnr2WeR4XlDqGkhZKvy6V/flbBTaVa96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760677685; c=relaxed/relaxed;
	bh=lMKro1feHta3Ev1l0OElUNRw/Zk/TZv7q1l/O5EtEYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhLxFWeBhOIoiV8jnSwthP+qxHdKTwxRijeaKHLSL2zY3+NADyyu2Yhq/QhJdj1hWEVfsa73Ili94NWoV+Ku/kekXX5zviXJUXBxCK7iYxdO61EXu05LpA7wg98qN+mjoOit7nLR0RhHfAJat9Dybf7cHWP+GKj/CEMd6eFuopuwVVOfAcRPJVbqO0yHKbddLF5lMc7YjjH6EoI3P7wSC/XLZHeiMAtdP81y0k7CrSQspzAAIv4qiPK0wwc7cDtDm6+k4QbvKVuYxlH0ibXnbWJ2zoU/BRWtHAvvNohLtI1npakRYgVDN5FeLaCO7p5swR9Mov70MyeXF/MruKFnVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=OGM95IMB; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=OGM95IMB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cntBB4tJYz2yhX
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 16:08:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760677679;
	bh=lMKro1feHta3Ev1l0OElUNRw/Zk/TZv7q1l/O5EtEYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OGM95IMBtiyOqcKal/dEideDcepT9sptwo/Xw+NOzQRmzIeUAnshfynJtDxc/7ZjF
	 nMlpFLYjQf7BOPFIN6EM8iyvPrzAvcOoUEZfSv1dags2cyaDA8ARoVoWaqwLK/I6ma
	 GjKL6et/Lgff6UDz+wX3FwhCda7jyYx0SAkZSd1rPyVBIYYlk53HlSrEh3hOPq7xh3
	 JTT+ofoadN30UyYWhhUq8umhJwRwueq138SpWZ70fC5fS2KMpz6U04RIu6i+aLMczo
	 X36BvXTM9J+h/NjXtcQcJA2FeusqtxyNrgwMn6elhj4RzFxNdIkmgdAjVEiXAdcyMn
	 ZUolDo7r0o7mw==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 60FC0766F5;
	Fri, 17 Oct 2025 13:07:56 +0800 (AWST)
Message-ID: <a96786b9020ad278fbda8c2007ad1c98ca41a4a7.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm	 <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
 Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, Leo
 Yang <Leo-Yang@quantatw.com>
Date: Fri, 17 Oct 2025 15:37:55 +1030
In-Reply-To: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
References: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
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

On Wed, 2025-10-01 at 16:47 +0800, Kevin Tung wrote:
> Summary:
> Add device tree for the Meta (Facebook) Yosemite5 compute node,
> based on the AST2600 BMC.
>=20
> The Yosemite5 platform provides monitoring of voltages, power,
> temperatures, and other critical parameters across the motherboard,
> CXL board, E1.S expansion board, and NIC components. The BMC also
> logs relevant events and performs appropriate system actions in
> response to abnormal conditions.
>=20
> Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>

Thanks, I've applied this to the BMC tree.

Andrew

