Return-Path: <linux-aspeed+bounces-1965-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEA7CA0EE4
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 Aug 2025 23:42:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c31y62D4Gz3bV6;
	Fri, 15 Aug 2025 09:42:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755177434;
	cv=none; b=clxfL4QeOU/0fdtXgnhhvr4mmTSR543f009FK12kLaIGMJN5Fo0TAs3z5r7PvHiCzTGBUweWsBMeWxUr2Kkf16+nKii9HcnaT/RNAchksdMfiPx06tpJ2TqRqlxbOIsFOR03clQMHoMKloAVrQk3FHjzbO/INPrE3zjAiVNbzx/i/8qGvAsvcruMmZj7M+9weu+rZk8ndefHCaaSp5ufT4jrqLYel2+cbWb452mQF7QxQlR0cOY9ibsm0d/q35epC6bUrlTda8o+pI6UHjdODQQ1Pt0vDZhZOm05+NFlUwKVxW5/SHq31+hpBQ4sFVLfm+LD1wNiFzj0hTm0uzDeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755177434; c=relaxed/relaxed;
	bh=vtNqM5cUWkHkJ7hl5Vy5tYw9YoAE/TzQUQgSXyn0i3U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T/HuT8hi4fp9QEwU7jJ9xq9fuYnWOjWVb4AEdnH+8wa499Jg6llBHY4tD/GGtmpAHdOP4DAzDpfIxl8TXZrJNFSWB3KGajR/9bgwBeOR7YQoJe0Lw4kkdnlyRww7raJUUVQDK1GCWNG88MAAZ2vbL4rxv7yu7Q6o9las3oa4iGdE6txiRzv82OWdFmV9Lqzz/ZtV3xFUg8Zhsi+6xWwDIZ8+hYiA8FxWInrdeVy8MMKuRAvDAKSxKbM9J2Kvg1GvYG/iTHUx27MiOnlmfxc9m+/BCAYUVB4Hlh41Da4JPbdqRpGZl/+XULcjAUrv4KvQpgVTJvDx9WizhT22Ev30FQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ceQlW0pP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ceQlW0pP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c2m491XsPz30W5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Aug 2025 23:17:12 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b47173a7e50so705122a12.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Aug 2025 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177431; x=1755782231; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtNqM5cUWkHkJ7hl5Vy5tYw9YoAE/TzQUQgSXyn0i3U=;
        b=ceQlW0pPQIZZ4AmqrZwF3e4YLmPjgYm5eAYVKNZI8XvAq8vHkhuSu6JzHYE336EKal
         5qcwC/6iLAbk1m0YH8bCDxQ3C2EwhBPyxGoAq8Dw7JiEK+ye5UgdEvka6sx6nasMR0w1
         3/y6fQ3n7FiVYGjjDpfvm0QjScj8VapO22xfM41wNzJUE5LerCQr1NeC5nR5y1+U7zRU
         6LJZXTMaLw8Si35Xkc4/rEj4ZiABc2zRkzcT+dibMlkJz3Zsr8UuR2yjUyP09J8pqz+s
         2Rn2KtHH3Ky1Qov3+AyaSMj7n5kCRdhnAZFw62U2Gp9F+1F4IXR+8/YpCmw6mdfwHFnx
         r3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177431; x=1755782231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtNqM5cUWkHkJ7hl5Vy5tYw9YoAE/TzQUQgSXyn0i3U=;
        b=ipmxyx97/1ffBPBtWZiQkSuqeVx5dHFWdk+CgOEk7g5NOwUwGhHtW5KAtkUVDyN76a
         JDmV2aGII9kCdk8mzKVVVDSN9h2qq+s94mdyI15vYQVRTEyl9+UeOWrqtdUTmhdztef5
         ypGBQBEPumoI/WGcOKFWCqqRd8YTqzkVWmiGbjvdRdARxV78Xo/lmc3wWjlSYS1uLRmg
         GyAksz3rBplrfB5pjDcSrhSn4jyleQFWXM0+Y3HGbafmnqLozBbg0cjwqQMFI/ID9aC2
         kf1Wk/A6Jpz4gaY4BxWm/nHJy/Yhxk0PuCtnQ788aHObhwrCnD0gzAVy9Ud0ce9RbVbj
         lMNA==
X-Forwarded-Encrypted: i=1; AJvYcCXpUgTg0fZ0354P7WrMbI2DAMjxY8dOqjuIckg/J/s8EyV6FyC16bv5J7l8zrupjErw3r2sxaxlDoKzwis=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YytBf8YZQPxPiRfxKdFoD+78ZwhBG4PJCVQ765Ku7SVefGJXknM
	PN7CNvRHnbNmHZxJYUlOGdGCXUe7Zp6cFxGyPkGXVmlYh/WTZcIxjkFm
X-Gm-Gg: ASbGncux4kv3TBbkRqoWYpldO5elmSfErH1EQdXOUpVt2RFNlwtStxkOXgbXMDY9LdO
	wJa0PkKoNWNaxDFmFsYHGEuWVD+R5uVQwX1ZSHQeZ1VS5EmPGcky5sZnbSN0TypAaklTmgu7fdA
	Hn+oN+SLlc+iAFkNlRQELsUhNVbrOU/LJh6bZqdwrlu50Q0kWLLlmO6kkbDtSi6cqwjX3SOzU9E
	FShc1A8H7JJ5rM4XByrzSxSQFK7aSsuYlQxgNBMVt7qScqJPsmaDCyRzcupBK4BcTpwxJzKV2hv
	q08gOyUqUC4Ui8xS0OvOmXUOgX1ZSAmKwRGeQvdKCxzkEEWfN1b3/xVrKf7/fzgNcuQFTUyi5xO
	jRlIevDKEFcQbm5yO0AJSupevMFCpQoXRv+VORiCJIqHTFVoWeERtDFhnJlouhqKG22WnU4Pda1
	bljA6bJH+bTq3ledcR/Rl7+A==
X-Google-Smtp-Source: AGHT+IFa7QfMuw5Y7JIUV4eh1A1Uc0XGu+XJ+9r3P5sIVVSAVSVpPVZ+2s3TAqMI+/lS4qOg8heSQg==
X-Received: by 2002:a17:903:1b03:b0:23f:e2e0:f89b with SMTP id d9443c01a7336-244584b4658mr43434605ad.3.1755177430731;
        Thu, 14 Aug 2025 06:17:10 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm335652995ad.63.2025.08.14.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:17:10 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Revise Meta Santabarbara devicetree
Date: Thu, 14 Aug 2025 21:16:56 +0800
Message-ID: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
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

Change log
v1 -> v2:
  - add 'bmc_ready_noled' LED and update commit message
  - add sgpio line name for leak detection
v1:
  - add sensor nodes for extension board
  - add mctp node for NIC
  - adjust LED configuration

Fred Chen (4):
  ARM: dts: aspeed: santabarbara: add sensor support for extension
    boards
  ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
  ARM: dts: aspeed: santabarbara: Adjust LED configuration
  ARM: dts: aspeed: santabarbara: add sgpio line name for leak detection

 .../aspeed-bmc-facebook-santabarbara.dts      | 857 +++++++++++++++++-
 1 file changed, 853 insertions(+), 4 deletions(-)

-- 
2.49.0


