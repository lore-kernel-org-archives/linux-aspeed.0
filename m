Return-Path: <linux-aspeed+bounces-3857-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E925EDB7D0
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 23:21:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr2J64xyGz2yZ6;
	Wed, 08 Apr 2026 09:21:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775570087;
	cv=none; b=SRDOhlEoiJw8GU7xQnJ6FBFsqjDLtQeI3R/sh+Pfo0mJV2g917b2rwUXoAUge6hMCgmdDCBxIpNjlHlsjWUfjJmho9rXvYsxkDgyg5FAI9vPt3LOZNoHg08n+MFQhUboXoAZxkZONZvRvRnAuGL7liaoGCcna+fkvbzpjQyps5qXTCNwqYAWvyVy12s84NCBgnsb4ANjaLYCSOglE00Jf/wPOGOVgoLIlq4vLE4HtDuCegTonYE9y3lXaqprQ4dEmIgRb30IPFRCINMVZIJPhC3YyEEiRgfALIH3X2w28ul55IvMFSar6AJGQ7TC3q7Zv3/Rxtj/5pelhd9dZnuwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775570087; c=relaxed/relaxed;
	bh=3Azm6ch8NFb4zTbwrUr8055qgKOiI+1Q2g+iDaKl9uU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BPfFizDG1gR7CAVL57dCshJDEed1oIXGR6h0OAzHSbMicA52iTmm1OeCwes8/4SnxZ2MHSZJcdOfeMV0bzGMqz4pWMIwX4/z8SVLsvAlAtF0fHrDYWyfniNUKxXe03XJt3neHFl/rlB9XJfz4tjJPm3r5v0iSt6cEvI/ddoteoa1I1CO2t3yhIhywuDuGsFeaTXEhLNKUiiaVXfyMdlkr6mRsIhbILQHTGuNrmpn0SUv6FsrGOI3FJYJ3tXWsfSGy3O2GN5RU0CnpOQ728shw7MfRORVfVg1uqb8YZ/zK6d71bn/SHsFEAsCaeJ+NIlO50up8h3vuFCOp4HGcljDEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pZc9ztUs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pZc9ztUs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqnkY64Fgz2ySC
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 23:54:44 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so5520982a91.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775570082; x=1776174882; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Azm6ch8NFb4zTbwrUr8055qgKOiI+1Q2g+iDaKl9uU=;
        b=pZc9ztUs+GiYP1iqymCu0ihW+lnS1Wicr0QaJU0eVnL9caSRZxlaav30kN/jqNjuZz
         nf5SfAhpu8WRSJM+3OQTRYtau4XZq1dDbZ16KEb7atfemMC+4ZgRJV057W+A3IzFaBpB
         Qhn44TUEnuoqAg3sYFagawlodKDpYzkY90vLVuZEpenV3KYScx1DntLskBQIpkIDo5EK
         7vHX2A57pV+NuQ5vwF2mVEG7yuR5OXJCIvaPQtCmNoWnbkLtasSVD8VSIWsnNfk+XCHs
         pM166dMUFCO6y5KjjJogtH6/ZIAMIAnts1eCcAtS9FVNeUX/OhDOea0wcZRJmbmD7rTD
         6Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570082; x=1776174882;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Azm6ch8NFb4zTbwrUr8055qgKOiI+1Q2g+iDaKl9uU=;
        b=FYeAS447ba8JYbcKv/yY/+3gEID9L1HYhUqhwqzWSr5WQSLQstCgElky3ADlRZna/N
         7rN3O+pnoc5J0M6WVRU3vkpkTYqNtOUssq7wcdup3GFnkMY0Owh7jY44rqomji6ymVNf
         AMlHL4sgAJXN6GSeIMxyplXkIJSSvoPxdEnsqCd0ejMIZpikW0vEpLBzIMpaoubp0xPp
         gTre64OwZIl9Dt2FzubwJ0UmcW62rlOORP+iFkimYhrGAlKIgP+Bs5Ip28+zhM0qfr4l
         Eti6/W2Y08yOHrXFqfjmfzBwrlIxDEuhXKMiksFr3zhoRWK3/XUVziuGwzv7IZQOR/YN
         /r7A==
X-Forwarded-Encrypted: i=1; AJvYcCXZfCHnnxs0u7gInEZ4zDzvu7BiPsAK9whGcA2zgaMogtZ6LdDgX8vmQtLMNMOREEGPRLrsRn+abwSFpnA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwT9zk+CRzVHJ7mqyUHtf6vK3/hySxUdvCj2U1koNbbJ1/R0dsn
	mlzztqx7X23TzgTgQTXSLe2YaihW1nji7N00sFGQ0LJ7P168h0WWy+QY
X-Gm-Gg: AeBDieuG8MrRwhs7aYRo/Ye1co4z/mBXq6+sJ2NTjZAE64OS74PW8s6ufGRvlR9VmKh
	lyf/d4INyHzJw2a2BuXzBEVUXNaBHGaz+OCF1cV0HoV7T+oTSM8vWKDsLvqq12ULakmENFZEVkG
	j7OuRNIKfu8X/AfsCen4DHKIRVSgQKmp7lIQEmqW6yETbwLXq5URrnAsuks3xcQgkKePxcQ0e3g
	zCuibaASUWF69Qzvslrs65K8UJhWQMXaQJvG7iVoJTCpKwlOAGwZp1U0TG4aqmpyjKpRPzeKPbW
	oocyj8TYMZH/zF4ewSGDmn8Obf0PrYm5WHjT3wKLg92cU4Vi4bREoVLqgoDbuuJOLDFdli4OSi/
	y4hw+DCq8pehGRN/DXiaOs7aZDp7tRfCrLPS46Sh0cvIxtUlpWg2imgI09wnjhLmPZCySMvnKmd
	x02M3ghRphkW7gwZyNn44=
X-Received: by 2002:a17:90b:1d49:b0:35d:9927:e023 with SMTP id 98e67ed59e1d1-35de67df8c1mr15929957a91.8.1775570082546;
        Tue, 07 Apr 2026 06:54:42 -0700 (PDT)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35364edsm17111559a91.0.2026.04.07.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:54:42 -0700 (PDT)
From: Colin Huang <u8813345@gmail.com>
Subject: [PATCH 0/3] ARM: dts: aspeed: anacapa: restructure devicetree for
 development-phase
Date: Tue, 07 Apr 2026 21:54:31 +0800
Message-Id: <20260407-anacapa-devlop-phase-devicetree-v1-0-97b96367cac3@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJgM1WkC/x3NQQqDMBBG4avIrDswiVKhVyldDMlvHZAYkiIF8
 e5Gl9/mvZ0qiqHSq9upYLNqa2pwj47CrOkLtthMXvxTBhlZkwbNyhHbsmbOs1ZcsIBfAXhw4mI
 /9c4HoVbJBZP978P7cxwnNkrKAHEAAAA=
X-Change-ID: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775570079; l=992;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=GuuPmRF0SvztskRDwEB1MM2bn2JoVv89mfGzEQQdwjg=;
 b=37ulHPY7QXaxwxBrpF05mKCYNz39UmcYPhg1ix0o5EU6aTX8zbf9G+9qqNsgYilWF/1k9OlaG
 tI6i/oQ7TjHB8LdcIZtdWK0awiBjxCPlQ7zq5OIiEG6ctvEtD/YgMy3
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

This series refactors the Anacapa BMC devicetree layout to better support
development-phase hardware revisions (EVT1/EVT2) while keeping a platform
entrypoint.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
Colin Huang (3):
      dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2 board
      ARM: dts: aspeed: anacapa: add EVT1 devicetree and point wrapper to it
      ARM: dts: aspeed: anacapa: add EVT2 devicetree and update wrapper

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    2 +
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 1069 +++++++++++++++++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    | 1125 ++++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1064 +-----------------
 4 files changed, 2197 insertions(+), 1063 deletions(-)
---
base-commit: cd44dc5ead3042f2873244b0598e39a16dc7b940
change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0

Best regards,
-- 
Colin Huang <u8813345@gmail.com>


