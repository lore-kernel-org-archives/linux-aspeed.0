Return-Path: <linux-aspeed+bounces-5018-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D1CC982D6
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Sep 2026 15:18:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlzst4YzPz2y2W;
	Fri, 18 Sep 2026 01:18:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789658306;
	cv=none; b=SQAEG3lzF26/qHYLNlObUd/EOzuLXzVLykxgDGPC5/pKJV8fIK1NIoRgGfS3evMZj7SBcvCnstkKY2YARlt3X8TgmlCoUb4mm1cPcYvQzoo8WRxm1ez4zs8i581cnigWGYpNwHPAu1QSqW1iGT0MIWpvGz2B8frBK5P6RVpvOfG1g4RNI8LFJeqOmLlk68eiShPV7UHyNtCAY36SN8C0XY1XjC0gjBDMIzX34sjcWJHV90qMPa2glzrvMX+3jwLNpS9BHoo0IqHG8vXlGObqSUrOC2uKp1PoSVmGX/mcTnyNVWX7ixXevuyQOyx8XNdz5ws/7qzcjTSJyEAA71omdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789658306; c=relaxed/relaxed;
	bh=OziTzy4SV0rdP7QT5/3o4LU2t6LnQ939r26ChBP3tKc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kP10BzApH0hmtPuiH4m+/5Tv7VSXJKohifmZzdZjU2dA5Mw+syrYLUojZwn1L59BFdwUHFjkjy7FEkZ8kzqFRp/ouUC/tGB5NJy7cl9Mc8a+TOD78JRBSTzyLsk56csySkyUvXUcfjrZdcImFDDfVU7XOUYOmcDZ9bSiXBSi4Yp7D9blElUCXTgJXpPp3g7I6yCitJN7Wkws6/uISVtueMFZBZ1DARnYDv7tUNCCzree0DyqBGB2fXFQH+QddkNMgvQhJFAMSgdjGT7Qn4qXVaGHXlgaqZ6ZXV0P7f83fHnTFp6Phz3t7WIjpS40W2sRQ57plJ0xJLTEdqQjQBV+4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RY09ORei; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CvR2SWYf; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RY09ORei;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CvR2SWYf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlzsr4x8xz2xfB
	for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Sep 2026 01:18:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789658296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OziTzy4SV0rdP7QT5/3o4LU2t6LnQ939r26ChBP3tKc=;
	b=RY09OReiAcYr4Db/Hsyzm0Y2unMJRSNf4hcZVhkmoDSaCwlGZbITj5h02wBi5kNzDwgE9P
	rBGAL10Dt4+Jr8t7tYlXIoULTvmnSlBFoYqGuPaNnx60HcsgMrUNpYMzVrEs2t49KDGdR8
	r7mJiRzcHxnHYzV0DTVXbN68/7wn7V4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789658297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OziTzy4SV0rdP7QT5/3o4LU2t6LnQ939r26ChBP3tKc=;
	b=CvR2SWYfXd7l7Utd9ZyeAcuuRWD+UkT9aO4uvz6UHMGqbrmzPufGTJcDeYzlyDZvz0kaIH
	YbnQnCtqrO4XW20Va9Sc55GI4x5YPE8mnKU41ociS0uVkDAypOzFdI8Uzd7aQlvaWllGzP
	v+/8tVMlWwbSbaEDuNzes3pl4Q8mbRA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Wua5G0nfPte3W6kPxoUv1w-1; Thu, 17 Sep 2026 11:18:15 -0400
X-MC-Unique: Wua5G0nfPte3W6kPxoUv1w-1
X-Mimecast-MFC-AGG-ID: Wua5G0nfPte3W6kPxoUv1w_1789658295
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52fc0097865so26630791cf.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 17 Sep 2026 08:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658295; x=1790263095;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OziTzy4SV0rdP7QT5/3o4LU2t6LnQ939r26ChBP3tKc=;
        b=l/7uuwxSB/Za914J/jusJFa63aakZC+Vn7j6+2sRsbwz2/18aE9mICiwYxA01AQGpg
         KunevN5g9VaCzUzbZGo3d+lxJPBmlc1p4VmIvnmo1Dd9PxK5/X/V7sTzBFSDbQLUlZ/T
         vjZGrzcEB4Gg+UkOLu411rvpdF7UsOtlvm07yUKGq6nYwMwAuEnMDf1ILIU98tydZ2dx
         iqeCyVwbt7YIEhKvRYmlJHrXYHuhJaAVm+m+Z5taGopPjjYz507CRXjFs7kkSRMMpi0c
         BXECC2igIMd8QCh/A0S5/WgjheLnpS8xFMmhoIqJqIkCaNvXl91kb0yPJklVy12nvA2A
         c/HA==
X-Forwarded-Encrypted: i=1; AKwUvBx0RR8irSzPNtIawXVVQJAq7LcMXvAM6f9VEzjvFum3noW2GIu0AydYWo9wB4l0toC2uqjAjIvhsXmJWw4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mNvW/Ts51FmZDE6U3ViAf0xb7UZ3BsklD+Jo5n5go/cCi1ha+4
	lmoMsIdHHHUnKnjOhvRbQgbH8r2uf992cu5lgTbx5KkgH1JqxsJ/BbfPPpCpiFbbowwgm2h82k1
	HbodV7/em+NsKBCDWoS2MwFGYbUmVz+Bf1K8rsIXmrCRULvnjJPbIXHcNqApoPsvnsJA=
X-Gm-Gg: AYBFou0bnTzYr93T2+Zi2TMMR8CuKWfRww3WPDpUt8Nd5n/8KkSI+s/wfkECW89jX7d
	K/nKcxWzelTAE2iL+R6+btX1xTeahF+g4jiIGc1iLgoPwlm1FKGMT2YTvIfiN2hIEOQNk64HbGU
	Q1cX6EKygualaHJ2FVl44eYVORrF2JSbCAH4M7SDvpdmtIlKWeyrforDilky5Nqgf2+IUTZB3xt
	G04fkt4txf61hjyNvqo3RZskXlNSqWUxcvSsgYLtY3A13gI3Q5aPKcAATdGyXYEzF+1bZcEpv9t
	b1Z/0RMn/6RhDSPJjQLBVaTDlSVuOawbxTlsELA23h+gZa+xF3lSanvPFjC098CP4WFnwGOhUAj
	1r/RcoMfXK/dOtEEggd8hqIXAAYzGEy36l5jpybE=
X-Received: by 2002:a05:622a:134d:b0:530:98bc:3974 with SMTP id d75a77b69052e-5327f260d6bmr122394231cf.22.1789658294546;
        Thu, 17 Sep 2026 08:18:14 -0700 (PDT)
X-Received: by 2002:a05:622a:134d:b0:530:98bc:3974 with SMTP id d75a77b69052e-5327f260d6bmr122393851cf.22.1789658294117;
        Thu, 17 Sep 2026 08:18:14 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53261fda5a7sm54054561cf.8.2026.09.17.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:18:12 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-clk@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260712160301.98941-1-kmehltretter@gmail.com>
References: <20260712160301.98941-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] clk: aspeed: ast2700: select AUXILIARY_BUS
Message-Id: <178965828458.360090.13517236488404002811.b4-ty@b4>
Date: Thu, 17 Sep 2026 11:18:04 -0400
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=292; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=QSpex/un9vsD7Byia08Y7HUcWbITtTxNA+HFXAQOZec=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLWsGyqkZNmczfufBfb+779J5fQtPJpbRs2ss5YGT/78
 Ot304+t6yhlYRDjYpAVU2RZkmtUEJG6yvbeHU0WmDmsTCBDGLg4BWAilUkM//PiL7I03vIUk2W6
 Fvyzfs+Sm7k/ln06lrqO50joxeuJffsYGU6wTCzReuWhmr77YdxKz1V+F1qlndQsDed9uuVbu8e
 6nhcA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8UbgQwPjXsexAcj_gGNqKhJkevOP3KBgwuCSWYHWqM4_1789658295
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


On Sun, 12 Jul 2026 18:03:01 +0200, Karl Mehltretter wrote:
> clk: aspeed: ast2700: select AUXILIARY_BUS

Applied, thanks!

[1/1] clk: aspeed: ast2700: select AUXILIARY_BUS
      commit: 8932b4283488ea91b1a67fae7a29a505f1d6e965

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


