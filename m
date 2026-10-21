Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435F606A321
	for <linux-aspeed@archiver.kernel.org>; Wed, 21 Oct 2026 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dneNbJxz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8ztY65Hhz2xwM;
	Thu, 22 Oct 2026 06:31:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792611109;
	cv=none; b=ko+WNacJuH0ZtfKOt6+ZM5/D/fFzhaVGEJUzpdzZi9loDfpHOejMnvckxdoMSnaPftNAcku0vPWfTkGWdjTNibWA4sYs2RectYwcRCia4SieaLI21p4DnJMh9e8UtGXNVwE0xD+EXvEFCEJhBdOFfx4BbnDvGre78zNWNDab2i+2AhrpGqJx/B0UIqBz2I3yZvNjw95WjgXC0xZda0//z9xThWpBXQ4b5eTrdvLqJiynQ16PBIRiXnlTXRneVUMnixPqHsa9ZiyVQtjGFBdICaeV278yYufNxtGOlTirRSRSGtuPmCIPZ9PsKTDxEB5eBmx7JQ47l/jiycBa+syhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792611109; c=relaxed/relaxed;
	bh=3dwvi8Bpy2jkTM5NMOT9ZeaArUVyCEJHSfhITQg8gn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4OcKfEYba1IivG0+V7AAe8LWGmOwmKAmIUM0NVomKp3QOEJ0YLc1XFunSDQGlMfoVIxcIfbHbquJLzN6yj9ugEdADXbu/gK6VjE7Yx9YCgd603BN6jfCCcDqRqc8+9A6GgCrfDv6TqsSGtLMFRKo2TUOMNi/lliZ90O+BgJ4kd3R5Gie5ZflFeWpwk3tSh42JBaZqVi3OYHBqHDVOazLYgJmTK5qRFeLGohIF9UnelVS8632yCa6nHE1EOPOo1eGtSEVAdejVTrOACjGIAJik4uCRVw+Kv/+YExGtDmyr55y74GOj8VuIVJzCAIDhKwVeHwnsn3Gord7mVnxy61UQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dneNbJxz; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dneNbJxz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8ztV53xRz2xPW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Oct 2026 06:31:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792611107; x=1824147107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=THW4sdUtHqOvMX2OSOZLFucPcnAbZSf+yoP9iqHJj0o=;
  b=dneNbJxzCH78BKjQsN6BsiNu0BFP3Q+3yzNG+DkL5h+yhUi9s0f3lVOq
   0czNHK+4VFZZRVgmL7YI7/guAyfRk3aD7LxVC0FbDmcamliXBArY9Voqm
   t46sk+ilrImoe0JXO45VP6LfRJObjI6q0QNscSBqvcyKtpLOQ0103QAHl
   BwfyiBP9cyPg8ZWg+QGHuI/TdMPpQyv6IEcIz0X1I0BqtuRJJjjIG+k4S
   xFaTqalBP/w/xAeVxyNtYBwCWjPZ80zKPMVd1K3/XnZXyrOTnVYxBFG5P
   G/vXNd1HgNlSdZhCdlvFsA30b39Dd9uTWnXgShjUE5udYdlzcdOmT7fk9
   A==;
X-CSE-ConnectionGUID: gOnvExbRSWqICQrWmLYpbw==
X-CSE-MsgGUID: Ij0bbZthSDetius7G6RUEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1382508"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1382508"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 12:31:40 -0700
X-CSE-ConnectionGUID: cu1H3ycBS+WuGh32R4bVOA==
X-CSE-MsgGUID: LKEf30hhR3KrVvjqgvin0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3170385"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 12:31:37 -0700
From: Dawid Glazik <dawid.glazik@linux.intel.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dawid.glazik@linux.intel.com,
	maciej.lawniczak@intel.com
Subject: [PATCH v3 0/3] arm: dts: aspeed: add Intel AVCRP and JNCRP BMC platforms
Date: Wed, 21 Oct 2026 22:26:39 +0200
Message-ID: <cover.1792613583.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial upstream support for the Intel AVCRP and JNCRP
BMC platforms based on the ASPEED AST2600.

The first patch adds the board compatibles to the ASPEED binding. The
remaining two patches add the board DTS files and register them in the
ASPEED DTB build list.

Dawid Glazik (3):
  dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
  ARM: dts: aspeed: add Intel AVCRP BMC
  ARM: dts: aspeed: add Intel JNCRP BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   2 +
 arch/arm/boot/dts/aspeed/Makefile             |   2 +
 .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 322 ++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-intel-jncrp.dts     | 276 +++++++++++++++
 4 files changed, 602 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
prerequisite-patch-id: 3af4bd880f896c97741b54ee18845b305a4bd061
prerequisite-patch-id: 23091b539ec7723a865d82da7703bf70c6ed0222
prerequisite-patch-id: ac42a7a373fdc407f6377d0b1c74d728af50ba42
-- 
2.43.0


