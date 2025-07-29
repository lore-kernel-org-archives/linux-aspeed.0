Return-Path: <linux-aspeed+bounces-1859-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1693C87FCA
	for <linux-aspeed@archiver.kernel.org>; Tue, 29 Jul 2025 23:18:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsB9X1K7zz30Wn;
	Wed, 30 Jul 2025 09:18:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753780441;
	cv=none; b=jbgy3go8eYGgpdlejk+r9TpHmJmC0FpKEgUElmxdK+gElkjLEH8VS9I8GQ6s761c/YpHqo0MqySrpXaahIR8Y7nb7Bq5i/4SOX3NihIWPLemih2OMLxT6KnTt6Kd7uWDvYlXvFMdaCqUqFJnNuYlrAqI88KjlHaSAWbh796pQM0SP223sFUDLyo7OfUBpRruWZcgg9bBR9KDvgYxm7jXlGgeZgSY28TXW+wYFuokR0BWawyDvOR/ERffi7GgwrAAUUthgn1OP7wev9zvTjMFqSSeg6IvrVKl0uFHWWjMSrg7Rv8qLTP9mwTWHIgEJwAmI7Aw12/WmVngEjmvBTpbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753780441; c=relaxed/relaxed;
	bh=SQyxRL212NH2CE2dAFaZIS3vSFyJbqnMjH8EoS/AicY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VW8o/iK7j/PcOVNHh2IN0Ly4lo0DoBE4+uP4625FeCP1Pdi+ioDVPUejRDxaAXb6hWEzOhuVuY0KIVcHGpKy5r+Ra30FOG8JiMh4hOz82KDQSzmpVOqbzI3DP3Z42CCxwwVTZ+2WVanAhRQEn6dPf0vjTh9ENb2QiShuchmfUewNwN6RsFnNMPjsEmHl2GtHCUxGuO5GwrQYv2dluSJXf/SU8RNEayEqM1+nseumFpC4rmINOFkLhp8CYml8tsrD6DLo1g8NmcpSmT6YIuUPIIW3U89N2tbLdZsseqMLIqnFsx97/ab+9U+GybodI27lLp/83qh7g1xRh0e4Okq7XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dAA3xr6u; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dAA3xr6u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brqQv6QbRz2xRq
	for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Jul 2025 19:13:58 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7600271f3e9so788480b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Jul 2025 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780436; x=1754385236; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQyxRL212NH2CE2dAFaZIS3vSFyJbqnMjH8EoS/AicY=;
        b=dAA3xr6uvEO2im2FQ4QdpeagBbxokFtTfZJNdKfkeduYzQOSbcBteHZDjqw9+XqMIX
         O9LFdJfl4BZv+Q+KgbacCMjCmdh0dCTc4TLs+eTToX9ec6EFR0//rlmzrvLRP1gt5e/v
         BKTWcysckftBeoFTIybBMosBzYdHjSLKQkkLe3DwcTDpNnxtHbxD0/cMWF/0dxQOYhod
         U3YNrnAo9dIFmQye+mXrBMS5CQn7XykxM9gTRS2liT1Y9nJjbrfkYobq0dixkP/4YUzv
         X0/dBSOLGdddgxqNY21CVUoZT6ekKDjw3amoj1+pBcpShCWprZUgTwD4N2j6eJRv9OW2
         Ct9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780436; x=1754385236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQyxRL212NH2CE2dAFaZIS3vSFyJbqnMjH8EoS/AicY=;
        b=rucC0smb9ShwmyDXZbWiHbeZyoQT/N/4btQ42oivjVruk0PyUiGq95z30i7YSbOxoH
         ZK5nmHVFpOn32wzvJSX1jyKbv4qyB86a6BjaI2UyKBvwRufjx53kp5jF0ehy2wPcEzui
         b31P5v2JtShzQ6uQgnToFvAmmDJO0ESD4tMi3BTKDBbH3rW4+lsWt9KiuU3OvdXXQjzQ
         1Sx31VN/qrL83Hg89ViEUHRAizzFh63nMNzrXCbIasSJl/bBxuaTuQMW+Epd1cNGD3T8
         dxJrHfkfHR4gkir+gSjH+qDHf0TJ2sukzZ2ndD+1MVlh2rH0EGpRsamGJQJJRyc+qhVB
         m0tg==
X-Forwarded-Encrypted: i=1; AJvYcCXN6EmqN2AEu9/vEkJlhHP6ZxeVdizENcAJYCODN4LOIYFPGjLUGYbkwbeGaHTmTvlJ+tJtYOBYG633IDU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyxaIodNDbfYocpB6cMYB5J8SBWjF6sSJBlVKrDrB31kNjb+3eR
	cNoXKWDr7k8nfn8S2+bfAsLcCRQBhhLhzzMGCqe2aAjaf53zF+XG295U
X-Gm-Gg: ASbGnct32LaXvwBZQjpZLfXDiqNDW7eccU/DNNwrZ1OYmv+atGyoupYHBuKDun9xqVj
	+wByJZw8IzSmt6mhSFYWL/fpPIblso5R1ULTJZtOym0G7xH+VdESyf6hKmImfUIjoPN+pdnoRWW
	FxpzZPwk/fQcKngxmPvNYVSvVaewUPtcGhhKqRiAMigpOlpEyMxtBeXd8XFP8TYRd0qDb0z9qHk
	ojvigbs7tNarnV4ENWd0P8yn7jAtWny57OczMAGZ2964dgcnMUd6clSadxmvDpVyzjHmvUS94bh
	PW95Lcv1mQY0iqxMdJ/PAp+GIJ+s6ZPrAI8pTaKX6uK8Prvy+0HvyyqPLtV8oRHVwCTdn1iXfvx
	O+iLKOIfU0X6aTLjyO8qOfxaAhjMhXtT7VWQKku4FXS2omBxe/VWp0PfPe/ldi64olFTai4RpYw
	o8LMBJbOQm8nfl2KvSL8OjdP7i5tzMGsEtCWbTMPGE0TIqOpf1xt2NdrxjBg==
X-Google-Smtp-Source: AGHT+IEF+2Zavb47/riBr9cIbA+jDv2YfAkypoAz4HCbP7aW46kup2+kr9hS5IwmTEmyf3wzvvaWQg==
X-Received: by 2002:a05:6a00:759a:b0:748:e2d8:100d with SMTP id d2e1a72fcca58-76967298756mr3498076b3a.8.1753780435773;
        Tue, 29 Jul 2025 02:13:55 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e38d-c586-0429-5c72-053d-8858.emome-ip6.hinet.net. [2001:b400:e38d:c586:429:5c72:53d:8858])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b06ddsm7528612b3a.121.2025.07.29.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:13:55 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Revise Meta Santabarbara devicetree
Date: Tue, 29 Jul 2025 17:13:42 +0800
Message-ID: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
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
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta (Facebook) Santabarbara.
- add sensor nodes for extension board
- add mctp node for NIC
- adjust LED configuration
Base on branch for-next

Fred Chen (3):
  ARM: dts: aspeed: santabarbara: add sensor support for extension
    boards
  ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
  ARM: dts: aspeed: santabarbara: Adjust LED configuration

 .../aspeed-bmc-facebook-santabarbara.dts      | 840 +++++++++++++++++-
 1 file changed, 839 insertions(+), 1 deletion(-)

-- 
2.49.0


