Return-Path: <linux-aspeed+bounces-1219-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9410DC3ABD8
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 May 2025 02:07:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b11KX1dFyz2yFQ;
	Mon, 19 May 2025 12:07:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747620448;
	cv=none; b=HQ+HgBxkQrfIXftuQrqqVpnM/w6/RtIi5je+exHVtttp8ycMtUi0oDOy4Z48kMCBpGoRZQY46e7/RQwIAFkN6y8i8lIOLcRG9NnaH3iYrg6wTNuZzoD+BDzX9GzhZhvNHDC0d4hQmXI3zpySiT52MyhTPEa/inb4RJCm++NrV5XPpKu/WqFIimf59BzeBtg0V+5067KYlHSfw6x1vlfgM5q2x1UDLtha7sJ6OBbMU4q+IHKuy3AjAn+zMRqtLh7YK87L/pWS9LEWgRadJvRTrn7S+MLoIFToIdjWTdG31s+TtgmvDVHAdeytQAtwZeS5Id/vRwZtTkCsqOLivGt0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747620448; c=relaxed/relaxed;
	bh=QbzqCiZt3Yer2/JpapDCEvzPUQewz2zyXItEveGU7ZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=loOZxZ0bfWXlioDDm0jpLkYYa4bSFEUhb4MQIYeIQAWXXmdW+TcZL2+UJgWzqheSME5JxgK5v3r17k++2kLREOTW9VvR9wTr+yV6b3tGGJbkirktW8EXnr4IspbCcWqrehN+h5+PEu6dQJ4/s9lLv3s/ChZ3SQm2iilWR6V0H9ilu/bHzBDnygb7K/lmeVntYzph09ZImX5MI3ws4Cm87vXZkXrsV+B1WlBxgLEnD1mcePKiTz4DIxoY2FvsepR3Vgtjs60MsQOqiTZZVN/E0rlBa3tQ2aYbErJfzpx7bgfv7QsLGuKEeytJWgptXSWGeV3v7LMTd8LR7unTzlmsyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JV2XVY1k; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JV2XVY1k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b11KW2CkTz2xJ8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 May 2025 12:07:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1747620442;
	bh=QbzqCiZt3Yer2/JpapDCEvzPUQewz2zyXItEveGU7ZA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JV2XVY1kKzq/n8Pp1dogVB2cLiExutn9gW+bHLc5lswCsqYkXIlnxvVTh98T2ng5o
	 ptMDwLGXWaSJ9w+eDlVdfiE6GY3oXTgYxzVzePpJVpVDe4BuSdCl1rTW3uvff53n3P
	 WqqdMZ5Xoe6dwA8T9CNFzf+pbzeeyyGIjdSDgr4lnVSe+cfC6YNfHRuOvwa9qMBkJ7
	 yBwDFt3JyMETjxFWRGi7fl0UBKCkT5lJMwevkrDPX9WfJxPIGsiXPuPpiKm397AYBO
	 sIm3014VSdNJJaqE7u7T5vXploRmdOEQynqvXkwJ80BtjSNDYJhLCcmSNZm6Oqedo4
	 M7MdBgwEBv9dA==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 10052640A1;
	Mon, 19 May 2025 10:07:19 +0800 (AWST)
Message-ID: <59519ffdc57a9c34dcbf0348d1f09058dc12fd97.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] arm: dts: aspeed: yosemite4: add gpio name for uart
 mux sel
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Marshall Zhan <marshall.zhan.wiwynn@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 19 May 2025 11:37:19 +0930
In-Reply-To: <20250508055612.2613605-1-delphine_cc_chiu@wiwynn.com>
References: <20250508055612.2613605-1-delphine_cc_chiu@wiwynn.com>
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

Hi Marshall,

On Thu, 2025-05-08 at 13:56 +0800, Delphine CC Chiu wrote:
> From: Marshall Zhan <marshall.zhan.wiwynn@gmail.com>
>=20
> Add gpio line name to support multiplexed console
>=20
> Signed-off-by: Marshall Zhan <marshall.zhan.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>
> ---
> =C2=A0.../aspeed/aspeed-bmc-facebook-yosemite4.dts=C2=A0 | 41 +++++++++++=
++++++++
> =C2=A01 file changed, 41 insertions(+)

Please run your change through checkpatch, fix all the issues reported,
and send the result as v2.

Andrew

