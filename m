Return-Path: <linux-aspeed+bounces-4331-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DE2C43458
	for <linux-aspeed@archiver.kernel.org>; Thu,  2 Jul 2026 00:25:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grHj34Bllz2yfD;
	Thu, 02 Jul 2026 10:25:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782951927;
	cv=none; b=igsBTaReo+xWDOrDr0z1VFVOZJfWAdpbPjnvJB6650Wx/7muta4BUBLQ4G5+MPUjPUYOtSmDdbauBAXedvGirQ6Lof5PzF2Z5GLRiXR3sUJsnAleEkTXuy5MdF8QkoZwkp4oXAgk0BBSGX0AFcwvxixYKUXm2Orhtpgaq/mMX0TAIsv5VwR7wWInafDTqNkndb/dI3hAs1umTmUg0AtRilq8MdfeCXX3TyDK2RNqTp9BCOzBxoW7CTZ/fMq4+X0JUDuu+an5au5sbE/xTx4heIn0+sl+JnMGrZmRAWW6f/6z0c314w308t5uZ9WD+z/87yvYujm7/D/KU54g4iQ79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782951927; c=relaxed/relaxed;
	bh=b23V63BD9BdyYV2a2cLuU4Mh+dF+RSGxaY+1gI7BIEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e24nO+VQFvCKBm48HCdqpOIooh/i1ChLTOE+jmi5AYryEoacyP3sReH/kaAx0S7+X7E0V0Eq295LVMhIKoz6X29AjbYms4ziKKl7WHqm32uZ8paMLjYO3YH2rK/ENbk5urkBFW+pGhOb4Duxo8obXHmr86oqZMQHh/xvb8TDwxKXqSHoX7u6+4WX6p2WKwmEzffynrK+2/MbOL/0rMFtTM+9wQJNRbNE/LijAEA52pq1Xz9HRFYlRnc4iJds/RKZfxbpeC353Op8t6lpaytSgyanIzXek8Mz+pNyWIunDt0mxDCN7DVaYdi9+LoI10L0b/vtJf6fuPrBr6nKzbL5jQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=h3bv4x2W; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=h3bv4x2W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grHj25hP0z2yf9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 02 Jul 2026 10:25:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782951925;
	bh=b23V63BD9BdyYV2a2cLuU4Mh+dF+RSGxaY+1gI7BIEU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h3bv4x2WU3f1qVa7wLIOYvub7fxttSM9mZv8n11Vg4VoIPKJIsENJXvbd+HN3ds0M
	 cNISPiqb448GaEdzSxe5INSLK1lnf5MpWUaVphXrhLC2jQh4ncUfEdnPHBL+RuQeKs
	 +wGvEbXl5aZ3PeTvwmt+3z8oz3eXWAJGGk7SrnnlNbDg0ev2NzTvfzw8XK4vHiEkmd
	 F9sQLOXnw7VPGED1Zvqi82Gpr6J/HfVYUbWIYf5w2n7mkSR3ny0AeN1/6cPPWmQQ4x
	 scUrVFdffYKE8fBRFXe9Uc0GRxKAUcwpnpMzfcoT47eg29b5eVu97Edxvh2UA36dot
	 GGbRjlpj+sJ+g==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0162A65871;
	Thu,  2 Jul 2026 08:25:23 +0800 (AWST)
Message-ID: <33cf45f92e4aa2ca985501807c3e4f74e1a10032.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Thu, 02 Jul 2026 09:55:23 +0930
In-Reply-To: <20260701171506.338614-1-karthiproffesional@gmail.com>
References: 
	<033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
	 <20260701171506.338614-1-karthiproffesional@gmail.com>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

Hi,

On Wed, 2026-07-01 at 17:15 +0000, Karthikeyan KS wrote:
> Hi Andrew,
>=20
> Just following up, it's been about two weeks since I shared the
> hardware validation results. I believe I've addressed the questions
> raised in the thread, but please let me know if there's anything
> else you'd like me to do.

Nothing further required on your part. I intend to apply it, however am
working through some other priorities.

Thanks,

Andrew

