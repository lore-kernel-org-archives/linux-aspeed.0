Return-Path: <linux-aspeed+bounces-1494-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87340C71155
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Jun 2025 03:14:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bMTNV1BYvz309v;
	Wed, 18 Jun 2025 13:14:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750216442;
	cv=none; b=RERTMgGXVaM2ncm0MFlXfFkQECASQsESl4jbY9DO1g+p5oDCtx8tESkwlDUXaJu9De6Q2KjBcG2HzYsO8m22v16KELoPU400Oq6QFa432kY8e25ynj1OJgmqEKl0jg8dX9APcXjh2QeP4rwGE2EI+e2tRisM45fkqpTVVvE1OtzsLS8wAieC/qAfKGbvjFu36rR6JxcFzt3VmosELKEqsdi33dNFjRk7ER90WjVVOhEyApQwtD9yYsO184qj8MYKvq4XqMQ7joTOApp/Itczb07fXz+SbEvQmGtyA8ZiUlAtoERaxiQfTebBGXK8gj02iOL6pN9c8Eiw99ea/pqpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750216442; c=relaxed/relaxed;
	bh=qT86h424nYLdTAkOvz9ER5uOyajwYCePBdeQLxVucz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oLSqlIi1k82Cf0WY2LRmwIMygmpTP+jFb2IuPcnLYiZCxzkRyFRM1fy56R3XOoMSPYFVJDHuMckfmxP+f3u1CMY6tPG/AWGaYKYqnIXICk+1iOqZB/T/VVyGZfkGsaLSAgpE9hAgRY7eW3P2+4Mv7FAahlbqF+rrT0QAd9IqGe0whxwdLJUhsIq1xrheDpW27OWpLEjdb3iL0MnX+Gk4CCifVIfUnkPb2C9jOUxenCXqUGzFLZ7c4ybh7VWH1vX6y2lvqybBO4fBTet13cgaIcsxoBkPChRbpmgj671ZwxoYA0WmEYFLtl6U/5ZP6MuqXgqrP6YldB2jNQ/0PYK6Og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jR+YlHRq; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jR+YlHRq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMTNT4zGjz2yb9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 13:14:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750216441;
	bh=qT86h424nYLdTAkOvz9ER5uOyajwYCePBdeQLxVucz8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jR+YlHRqfz8YKs+mED5IYWbU351OPKnz7teywKpYcWH+65SpUb1gMqspwKGQ1bjk/
	 SacJf8XdpGfnd+N9l/OzTrEdG3j8geM9WU+7UF/RODEgfvdvPzTO5CbHeBpqCTAo3b
	 kVJgy9gR7HWRn3d8h5XJFrnkvGeOC3rTynsEFPX4ZzIspNhPVTdH6iUDnNX6KaSv7m
	 dgp2CzJx87nrFA+jcs023omehUCFnui5Djl/MTXAn6batm822RL23a54wtzGWD7A/Z
	 ekALwKYDeIuXBMcYTvUqCjPQxJwhERWfKKsvKIHl8LEfmQNzUUoRmQu7X9Rj8idKwF
	 8jWB4wjNvSodQ==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DFA7E640A0;
	Wed, 18 Jun 2025 11:13:59 +0800 (AWST)
Message-ID: <3fe67d60b145a1aaf1ceb19cc490d22c6aec27bd.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3] arm: dts: aspeed: yosemite4: add gpio name for uart
 mux sel
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Marshall Zhan <Marshall_Zhan@wiwynn.com>, patrick@stwcx.xyz, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 18 Jun 2025 12:43:59 +0930
In-Reply-To: <20250616091456.360388-1-Marshall_Zhan@wiwynn.com>
References: <20250616091456.360388-1-Marshall_Zhan@wiwynn.com>
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
Precedence: list
MIME-Version: 1.0

On Mon, 2025-06-16 at 17:14 +0800, Marshall Zhan wrote:
> From: Marshall Zhan <marshall_zhan@wiwynn.com>

Can you please fix your setup to eliminate the From: line? It's your
own patch sent from your address, we shouldn't end up in this state.

Also, can you please capitalise 'ARM:' in the subject?

Andrew


