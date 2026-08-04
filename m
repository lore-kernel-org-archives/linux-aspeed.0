Return-Path: <linux-aspeed+bounces-4602-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F6FC55172
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Aug 2026 06:16:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDjwY0r91z2yMl;
	Tue, 04 Aug 2026 16:16:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785824173;
	cv=none; b=Mak/7JHnQGeaFZlM2ShQWYBSkneHeorp/GWE/Q8BVEQ3dohCbLnYR0Q9b38XbvjaSRPyfrzk96KRKHlmYfI/QRw95t6AxfvjHCLXRdZLCVoUSFV9d5ejJ2Kl2tjEp06+/R8i0QuLKS56gQNyNOMEpDR+oYRy2nSzOIa1Wmz87vOgv0Lmi7gvx0azPj1iNZsyi442HIV8jEi1OzuRk5CF8Rp/T4f7X/+P9rZx4uf7acIY97/qoEqEq9IUqjCxNX+4jshWbOaxzN6sDCzgSdtxMDlb/7kq1sfaHN68TTnKEpjAgaUWNYNLjP4Gg7q1oUm5Shf650pidDz9sbWCvcN9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785824173; c=relaxed/relaxed;
	bh=cGFVWEk/L87zAQqYZdNMd8YoKosd5LHXs3b+GVvAT0k=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=PSUapbAWBZe1YzmSUCrfO0klK7QHjNCnQJwWMmmvMES5nwgpdCl/s/MMLU9Csk7n+W5WIRkc77ViU1qnf3wbHfFnHIEl+RjxXnB/53JDQb8ci4h0S79GhIrd9qD8JOLXJ6IYtFruLH48CwAJejfKtQBM4UAvdz9f//uHX5HOy0VEXXPjJ/1oDqSGRzL59eiGU3az1RbffuAEdXP0MCG24QncNHmrXKwXzGY9/d0UbRzV25+A+8JS1KHqY3Kn5elmQlsxD1mhKWo3UTOHp0yGAXNZJX/+gRvCdDerx2ryCpZikLgfj9NnjOsO3chBBvjL43IQNgbrgV2Hiy2xG1euuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eusIPTTu; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eusIPTTu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDjwX0cTsz2y1Y
	for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Aug 2026 16:16:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1785824170;
	bh=cGFVWEk/L87zAQqYZdNMd8YoKosd5LHXs3b+GVvAT0k=;
	h=Subject:From:To:Cc:Date;
	b=eusIPTTuYbmRVVvOhrqMqqRgdx7nr8X+xGcc+Lb5c03llC7uSJ1VRV1Gq+zjBt4a9
	 jnII96cWyimPkHJKRjtcTIoEUUaLjsQggOKNyPcWA4/2VLqGLhZdF528vIM/SqHK4k
	 fFgj0XJvxwZn10h0uA3QwNZdIS4SISqwHQHKMjfEZqqjYAoPns3GfrTwNXLDB2zvkY
	 8bGTVTtO+oZk+A4+63X0XPkvtdFl0zn8Uox8A/Y998qL6LFrTpaTWv4mpXR7Wyzoiy
	 nHqYHX4o5fooh9nd36GSs4tVEHlvrej5DveWgF14izzCNlu/7X+QCI8n3V56+8BcGN
	 EcHnt2wayulCQ==
Received: from [IPv6:2405:6e00:242d:870e:1a3e:8259:e4fe:6a28] (unknown [120.20.146.186])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C43ED655A9;
	Tue,  4 Aug 2026 14:16:08 +0800 (AWST)
Message-ID: <7028fd175c1cab44bc7696b5cb92282180e1f0dc.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: First batch of driver changes for 7.3
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Tue, 04 Aug 2026 15:46:05 +0930
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

Hello SoC maintainers,

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482=
:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-7.3-drivers-0

for you to fetch changes up to 244b7f86d60544c99f6e3774fbf0e1aafd3a30f4:

  soc: aspeed: add missing MODULE_DEVICE_TABLE() (2026-08-04 13:46:20 +0930=
)

----------------------------------------------------------------
aspeed: First batch of driver changes for 7.3

Just the one patch adding MODULE_DEVICE_TABLE() where it was previously mis=
sing.

----------------------------------------------------------------
Pengpeng Hou (1):
      soc: aspeed: add missing MODULE_DEVICE_TABLE()

 drivers/soc/aspeed/aspeed-uart-routing.c | 1 +
 1 file changed, 1 insertion(+)

