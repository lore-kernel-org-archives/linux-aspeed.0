Return-Path: <linux-aspeed+bounces-2335-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01158CAC5A5
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 17:30:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cX3lv58zXz2yqg;
	Thu, 25 Sep 2025 03:30:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=173.37.142.92 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758735051;
	cv=pass; b=H8lXra40SvV2Z6MltdnSXgpr5CqABz7BQqF/IBjSsXmcwxTgeOSvvDd4vWsEqKrgZM9+4LJtxBIu+g5l1CgxpnwpA3cLHRjyd5AYXiXqUDbWiB/bzGar2ZDVNvG/z4PGPgpuLU7qvj/FNDpJZFcaXE1tk8ykOXO0lFdEvVBPVpuf4tT7arznzQgqYhb8wwEwQLBSROIS/SJWDdoYOd/Q9VqHZZbve6sIdXkgWsSoWN2+Ychnp70SGj5v6Y75MqPf/UbjA+f1y1snGK5ZmuYdWNdJ23310h3V3XuStTjGBbsM11dLhV9albSAuNcTmLLaKiBGlQR+GgaArmnxHv76Jg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758735051; c=relaxed/relaxed;
	bh=T4l8kC1Bj+GgiuRgaWCOr3r8UJlzSs8VsA2jtucNHlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Grsm/helOMStLNOxj6j31KM0b9l0sAkH+NJ+ALsB2Jkg+XGKlqaqXB6BPRnjNXQJvJRK2LxxblvRbG0Dd7XCZd6UuDDdIWxsd9deb5a2Ae0/b+aQIvz8Cdz6Gha0FmFN+8DjRnSyguU6ZxQr38MCNCaMJMX7YYKqyB7LLI/M+OSTBGR66sTt/7mKyH5zOQOwC97gGL+b9pky+LqPAmvRUpnADTms1yFk+R8tTmxtKhcVca7XqKRcmSDr0yuMP0e53a0zmMDKBUxyhX0co4/gt/C9w91eTqvKSi1EL04BeJJk+dIlerZMaoWDJwmw4/LlUw0PeaMqL5Nh+fjfyGy2hQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; dkim=pass (2048-bit key; unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=e+70Qyrh; dkim-atps=neutral; spf=pass (client-ip=173.37.142.92; helo=alln-iport-5.cisco.com; envelope-from=sschaeck@cisco.com; receiver=lists.ozlabs.org) smtp.mailfrom=cisco.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=e+70Qyrh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cisco.com (client-ip=173.37.142.92; helo=alln-iport-5.cisco.com; envelope-from=sschaeck@cisco.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Thu, 25 Sep 2025 03:30:49 AEST
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cX3ls2C1Mz2xck
	for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Sep 2025 03:30:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=458; q=dns/txt;
  s=iport01; t=1758735049; x=1759944649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T4l8kC1Bj+GgiuRgaWCOr3r8UJlzSs8VsA2jtucNHlA=;
  b=e+70QyrhzGF2LcBA9Xa9BT4MNgAQ7t7AqYZ2Y0DnlUMl0TDItRCERFQR
   K6/irJBi9vYy3zVsVqzNMEXje7AD9JWSFqxwnztU1pAAJlP+LwIhIJnCx
   LvYfRovNPNFpJ1/N55bNIYRXGc0+6NRbwb88g/aVkG2vD+qHXmmiecXUg
   4lgVW2Nh9n9RnhUhTZkJx2Y+cw+bh2XsLxV4+WyCHVajetYrkFWGz/l6S
   lVVzB9qz7EXN573d1udNhWMD5lNAZEjiYhadWU0S3q9Jmr3uLuWyPI09T
   iRKE/oMyMqJB36JGIemqmJJrtYUtQEmr/xnVMW1FYkasMDsqEf6yQ7VXV
   g==;
X-CSE-ConnectionGUID: JzTC1nJfRs2KMFXS/9JGTQ==
X-CSE-MsgGUID: bKXd1VgASQeDdfk0ovtSsw==
X-IPAS-Result: =?us-ascii?q?A0AHAADxKdRo/4oQJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBGwQBAQEBCwGBbVIHghdJiCADhSyGVYIknhqBfw8BAQENA?=
 =?us-ascii?q?lEEAQGFBwKMQwImNQgOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBB?=
 =?us-ascii?q?wWBDhOGXIZaAQEBAQIBEig/BQsCAQgYHhAxJQIEDgUigmCCTSYDAQKpfQGBQ?=
 =?us-ascii?q?AKKK3iBNIEB4CaBSQGITwGFbIR3JxuBSUSBPBuCaD6EQ4QVgi8EgmZSkDCNI?=
 =?us-ascii?q?kgKYhYcA1ksAVUTDQoLBwWBIEMDNQwLLhUjSwUtHYEnd4QUhB0rT4IccoF0V?=
 =?us-ascii?q?0GDUx4Gaw8GgRUZSQICAgUCQz6BawYcBh8SAgMBAgI6Vw2BegICBIJHgRJaQ?=
 =?us-ascii?q?AMLGA1IESw3FBsGPm4HllaHA5Z7sB8KhByhcQQvg3GmepkGpFmEPQIEAgQFA?=
 =?us-ascii?q?hABAQaBaQE6gVlwFWUBgjw/ExkP3BV4PAIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:lvHmehIjcxC0ZAwQ1dmcuVQyDhhOgF28FhQe5pxijKpBbeH5uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1oNwg==
IronPort-Data: A9a23:ksQJxatiJz3bBfLxa8xCloIiSufnVAFfMUV32f8akzHdYApBsoF/q
 tZmKW2BbqnYZjT3c9ByOYu+8EwF6J7VzdVnG1Fv+3o1H39GgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav676yAlj8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGaDdJ5xYuajhJs/PZ9Es11BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw2PRLKjhI1
 /IiM2ouSz6zvKXn4p2Hc7w57igjBJGD0II3s3Vky3TdSP0hW52GG/yM7t5D1zB2jcdLdRrcT
 5NGMnw0MlKZPVsWYQd/5JEWxI9EglHkaDZYoV+epoI84nPYy0p6172F3N/9J4LQFZkFxRnAz
 o7A127aMh1DCtO28gOI3n6ihbfIgz/AQ51HQdVU8dYv2jV/3Fc7DBwQSEv+qOKhh0Oyc9ZeM
 FAPvC08qaE47wqsVNaVYvGjiHeAuhhZX59bFPc3rVnUjKHV+A2eQGMDS1atdeAbiSP/fhRzv
 nehlNLyDjspu7qQIU9xPJ/Pxd9uEUD59VM/WBI=
IronPort-HdrOrdr: A9a23:VxswbalZ5EPs0kecbyh2G2uoJLHpDfNRiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtj/fZq9z/JICYl4B8bFYOF/0FHYYr2KnrGSsgEIfBeOt9K1tJ
 0QPJSWZ+eAd2SS4fyKhDVQVuxQv+Vvk5rYxds2rU0dMD2CApsIh2wWe2Trd3GeBjM2eabRf6
 Dsn/av0gDQAkj/Gf7LfkXtMdKzwOHjpdbNWzJDLRgh7wWFkDOv75DHMzXw5H0jegIK640PtU
 zenSLExojLiZyGIxnnuFP73tBzop/M29FDDMuDhow+MTP3kDulY4xnRvmroC01iPvH0idprP
 D85zMbe+hj4XLYeW+45TH33RP77Too43j+jXeFnHrYp9DjTj5SMbsFuWsZSGqc16MThqA77E
 t55RPBi3ORN2KZoM3J3amOa/itrDvunZNtq59Is5UVa/pvVFYYl/1twKoSKuZCIMo/g7pXTN
 WHy6rnlatrWELfYHbDsmZ1xtuwGnw1AxedW0AH/teYyj5MgRlCvgElLFx2pAZzyHsRcegN2w
 3/CNUiqJheCssNKa5tDuYIRsW6TmTLXBLXKWqXZVDqDrsONX7Bo4P+pOxd3pDnRLUYiJ8p3J
 jRWlJRsmA/P0roFM2VxZVOthTAWn+0UzjhwtxXo5J5prr/Trz2NjDrciFir+Kw5/EERsHLUf
 e6P5xbR/flMGv1AI5MmxbzXpFDQENuGfH9euxLLW5mjvi7XbEC7NarBco7DICdZQoZZg==
X-Talos-CUID: 9a23:XescZ2225DTmDU7hVCySSLxfONIZWSTb7nnqOBWbLEhZc/rEa3CswfYx
X-Talos-MUID: 9a23:FHiBBwY6jMOJauBTvRzciGhcO+5T2qmCBE4OyZIYp/KfKnkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-01.cisco.com ([173.36.16.138])
  by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Sep 2025 17:29:40 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-01.cisco.com (Postfix) with ESMTPS id D4612180003D5
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 17:29:39 +0000 (GMT)
X-CSE-ConnectionGUID: gPWyVfTLT22JIm1DU9/uBg==
X-CSE-MsgGUID: sAQ7NA6wQouqj9FtoOeFTA==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.18,291,1751241600"; 
   d="scan'208";a="39253471"
Received: from mail-sj0pr08cu00102.outbound.protection.outlook.com (HELO SJ0PR08CU001.outbound.protection.outlook.com) ([40.93.1.74])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Sep 2025 17:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exHJ9iYTnZaXOgz1uPIeiGlfPvpm1hJD6OhK48shYYNolqUhCOjDziklMIDI1z06NUfGro2LgM7TGJrhoQpzGKFSG/neFcTQZxI3Znf0dfYoU+XkUUoh+pOGnqX3su6E26zYrjp7A8YQEZsriyWiFAvnEFVfJ6gWTmQHAjlATrVjh1oF6SdrbIA1JFC7oLaE86CmxxupzuSkSR4Vl9dBRckQCHhnRuBEthSBNCQCl/3m2MbxM9qfNEwvzrff+ME5hoQdWOE1KM07xQSKA1rQH6q2nJRHpo1OkzsrRENJfqk5POeKFVXlikU+vpe2mCRImVANXVsdRgiAoHrlg30HuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4l8kC1Bj+GgiuRgaWCOr3r8UJlzSs8VsA2jtucNHlA=;
 b=WGFX6NEZgX9yYEQftwSOWWa6pnq5OBmJ76KEYdGh6Th6hExSWpNV8Jjg12qps81lMT+8yBgP65G6nCleAcPrf1VD3inD2MprUeMn2dK8fDpW9egTuUfTdM1R+tMjybtoUYIQEfPKZKsr4uuS8o0cx4GMZUUWAtxBMeznQE/D3Jx5e19NgFBzQBZEB7XSlaA/+HL/wT8Ok7FuRJMv1QeUqr+NgVufGEWBZ/fgL3bkbQOelgTDgUjhVK8JWwLUF6Sejav5ld6rPLQYC4QPrKVuiqDHmdNU7xGF/jYn+uhrmjLKB7Q0ZmxXOgduX8pGQY3wtF+Kdp9+hH2qxrFHgL+dlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from PH8PR11MB8108.namprd11.prod.outlook.com (2603:10b6:510:257::6)
 by CYYPR11MB8358.namprd11.prod.outlook.com (2603:10b6:930:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Wed, 24 Sep
 2025 17:29:36 +0000
Received: from PH8PR11MB8108.namprd11.prod.outlook.com
 ([fe80::24f9:339a:70bc:39b9]) by PH8PR11MB8108.namprd11.prod.outlook.com
 ([fe80::24f9:339a:70bc:39b9%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 17:29:36 +0000
From: "Stefan Schaeckeler (sschaeck)" <sschaeck@cisco.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
CC: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "schaecsn@gmx.net" <schaecsn@gmx.net>
Subject: Re: [PATCH] dt-bindings: edac: Convert aspeed,ast2400-sdram-edac to
 DT schema
Thread-Topic: [PATCH] dt-bindings: edac: Convert aspeed,ast2400-sdram-edac to
 DT schema
Thread-Index: AQHcKZ802JEjjJGaEkyYuLZKcCcm1rSelnGAgAQGvYA=
Date: Wed, 24 Sep 2025 17:29:36 +0000
Message-ID: <60D59E9F-B7AD-4A2B-A3F0-AE15EDC6B89B@cisco.com>
References: <20250919195326.2079446-1-robh@kernel.org>
 <0fc79e55e5fc0f8a43586ac3f90599b8f2a6c817.camel@codeconstruct.com.au>
In-Reply-To:
 <0fc79e55e5fc0f8a43586ac3f90599b8f2a6c817.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.100.1.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8108:EE_|CYYPR11MB8358:EE_
x-ms-office365-filtering-correlation-id: 5a03f50e-3b36-4201-91ec-08ddfb8fef15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|10070799003|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2CPPoivqXCAGpj3Q84r/QfUQyQ/DXF6JpgQyZixkTY3Y7qbtN/KSHuRdpIvj?=
 =?us-ascii?Q?buCGbX2EgC0zw1rRwLi+NRuHdOMfqjR0ZmFudfVTfqmQpeavUqgrAWqmrFN/?=
 =?us-ascii?Q?+JnI7prV3mluGnUgLZwQhN3jwxf/sVk92vj9sNHff44lsl5MPpz3/En/RiUI?=
 =?us-ascii?Q?WwqAOF3U5PgdTsNdN8ajtqMT1//hnchgIgyDKgzpwIP0GQYNOnvp+fdTnHIX?=
 =?us-ascii?Q?WoE8Sj0ciW7QfeTP8xFStaZR4BJjwfcDFVI7SNFpw8yihx/c6i0/dtmVRX6+?=
 =?us-ascii?Q?kimfe2ICv5Y0fDB95kabQcEpMFcYehhgXoXvTXX+/qsCMY0Y6oRiJ4Y5xfWk?=
 =?us-ascii?Q?BesF9aIhTpsKjcHAIUqXcyx6qniZEECrztsCV+ODwTGrF9qlRSnT13kAXC8q?=
 =?us-ascii?Q?kgY6KMEBt0+uRIRKgiUZlvQSAeCMrz3p6IYs4yKDwXDLkXfNyG0fQHiaUiHH?=
 =?us-ascii?Q?GDcIb8jxwIcsU6kGiMrI4xaUry99REcseRAQzgK9zdFSk0KvoMBlbD2rrn7j?=
 =?us-ascii?Q?10KqnyFvX+0mp7A9oLM62pCQUonC2WV9yIBCLW3JXfuSdekObujalyeD+v8H?=
 =?us-ascii?Q?JZ1gofqI9Ch4aO2Co0BaTqU1omH+IHdsI6t4yyyFyt+3F5JJQcp39j0zFlgG?=
 =?us-ascii?Q?DPYNfghQ8UB6GTyGOGmJBMa0S8q/dznTE9s4yHXqHsp6KxboxM8PkwLaebhN?=
 =?us-ascii?Q?mR77h8+Agfhk7QlzhAhpsEkBZ8oVZcw6gqRkBzsKXj8c2JMBVGYJucFn6MX6?=
 =?us-ascii?Q?V6fZ0oSYPkkNd3aiza16+xyV00ILEOgiDGfZVs+XdwZtG316khR3l66npuDc?=
 =?us-ascii?Q?n2R6ISAIyvsHPL1rc1EbtIT9n+2gSSWG2Uw/c6AzZtrIYLciaof4er7vQmv3?=
 =?us-ascii?Q?WlbCb053HCEH9NGnNYdmtzhm2PmsYwS/mi3b1Qrx01ZXDOsZzuO2QnynCYie?=
 =?us-ascii?Q?JiL8/+6PsAL2MCBxYznRZErQpmU3BX/Ybvsc5cGVP+VotW/fDTo8LZZs7rBM?=
 =?us-ascii?Q?X+N4DeT3HxgE7B1vkZMLf3XuMFL8vQbMjUb4EnQwY9CAYFrFm5fwbCsKzymP?=
 =?us-ascii?Q?2uA9Fuqg/r6rqN1Q35UilRfxJwTiQ8QQD3uWjCos2q2mPJ/FKMgnmvGCKcla?=
 =?us-ascii?Q?KfBctFqFTlbOd2SC0oWhZXRwFJUTr/gwuFp+W06ji84WZkyPqYj3fiudWop2?=
 =?us-ascii?Q?MaShDfaaDsuHhdmVCeq37Suvb+oUwTbtM4Szo4Uob2zXLaEKle0Gu9+uLPYW?=
 =?us-ascii?Q?OUdAZXLaIgGh1ZwDEM2ciykMSig1YlfC2P6mGlUVRBXluQVuuNYmZ6EuS8Ss?=
 =?us-ascii?Q?YHoBFB4+bfdlu0u63Z5RWo0sLziDNrXhuWK5mjG1HXHhOcb+PMeYSh53xoLT?=
 =?us-ascii?Q?OLLHx1+FGYY6TDovEbwqC0E3jMu6whaZyu7NRIC08nJ3jhzw7q7zQetnZz3n?=
 =?us-ascii?Q?AvdxfH7wly32iUqydm4KSKvkHtWPk/TDdZesecYdK0wIbbkgSYN+EgKGS2fe?=
 =?us-ascii?Q?/uIpEdmtSP2VgGw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8108.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XE1B9hZhC1Fgfz4/UWHyM6/N098A8QoePbWZ8MXR05nCXcef1pnFiR1U1e/D?=
 =?us-ascii?Q?dUbVJ878tKxqDu+6vgLr+qXdCJiIH7tk+pGWSFqDTJM+4jG/sEa8uhwlFpDF?=
 =?us-ascii?Q?7v4HPZXSp7oTxDiHvEM3Yuuna1nJ3zK2s9O/SWtTEF4TXod5jnJ2UDQvDMYR?=
 =?us-ascii?Q?kXB8ddBLT35hjrowDs2PYwpNinrAYqMQuyENXmaTAH7wd14lSPuw4xuKuA8/?=
 =?us-ascii?Q?VK/s5UuG9vhZCQM5zOr8kmv/a/g4kZBL+6BhR0SMehPjEDpYhfEdsVyAr67m?=
 =?us-ascii?Q?znSIhfqMk8Z21cisr1XSjVWdQ6zgMDiH6dpCPOQusU9j78buii+glVbn5UBg?=
 =?us-ascii?Q?rSiVAXwhOoppzyH4NvoapR0dmitxjWTSlMWRIik2A844F7CJqapWhkUiyNTf?=
 =?us-ascii?Q?LICCo8ceyZtbq3SIzr5f5UrPyhpo3SleAbKp5UXxb2GCr8zzSF2bh41Mg0F2?=
 =?us-ascii?Q?Wz1pCHQN3J48uGJlodsI/re+AqkSSppNiC+luzzqqXRtUk/ckFZLO/QR0Avo?=
 =?us-ascii?Q?h9pIJJJ+a/cr8M1E9vG8Wm/FI8VQ3t3EwJN/KailDwpk2wibnD2vsG4na5xz?=
 =?us-ascii?Q?okyf1ZFCBD9zripRFfADv3LsmUaOWWY7/Yv62Xhq5SwUagx3HI36/YOIB7Xt?=
 =?us-ascii?Q?Jd5Hk9ScpIfzEwddrft4BGdXmd71r4Je88cToMlXaGJ5SiVH1RWaKHx4aG6R?=
 =?us-ascii?Q?tcNtNA/kLwLarpJo1RmMn3y+LgC9Ln0Rxf+imPhNaklqkoMJxFObwvqbsC3J?=
 =?us-ascii?Q?Sco3H70SpnaopuBcOO+v5gJw9jZIehthbscUjtlp3sQjZ6WyiN/PvbnrkPyE?=
 =?us-ascii?Q?Rr5N75BUutZ99OjpZIXaqZjrqP1eonM9n03Dh36h6yvl8inuxPWAY4Xlmbj1?=
 =?us-ascii?Q?/nCRjoqwcKylDEAFutNnvLz6DRj4JU1dQIk9Nhbpnfyn5GKb1ZNHo7m7eXAi?=
 =?us-ascii?Q?8hCaY/ULuwRL5oRedKLdMIjLLDXKWfSPLZRmufFHK9wV6zuhG7g7CwOXVWQH?=
 =?us-ascii?Q?RuLsceKY6aA/HJPRxYuHjgdqgVYAz3uoPXMb8UIUjRtkO9vk4aFEIge4bl7p?=
 =?us-ascii?Q?mOddGAhtHQAp9BwjjNa25bMckOFJ6GmQcEFkaDiwfxfsAAip34d3zygZV+0M?=
 =?us-ascii?Q?N/pkk+bwZ+7pdEljge+h8oXfzSVkPPjzNsQ7mMviFf9poEwgUb/PIn3BtQXt?=
 =?us-ascii?Q?bb0WM13I/n3Q+Tn7+FJ/vur/yqXVpNJ4lTVdhhHDCg/H2MqJaDuwhfgVWVQz?=
 =?us-ascii?Q?Oa9e6y8kCbXv8K9RhBmKabzOlHkMvfXhrHf9X6cQa17GMgJNq6Fh94MflSbA?=
 =?us-ascii?Q?m7Edauu0Vhw8xvzFQ8Ft6Kbc+m6HsdVqliNJiGNaVGxkpFI43Z8pNoTnYH4+?=
 =?us-ascii?Q?oAsSNQblUiVNdKo/EM2F/YtJGR3oHLdi8tNYKuNXt6+agt/qlba9fvoP+N1X?=
 =?us-ascii?Q?XpbFUw//qDdEA1wQzm3Hn4dGzf+5+ibwHUT4a+CSjcKee7QohWcmnPjiGjkA?=
 =?us-ascii?Q?v0RM2bIIOrvQeoigO9aQH9DaeoZaYTxUjTPmhpQmu0nzfWtrqauQHDWuiNaC?=
 =?us-ascii?Q?BSmkPPnYM8I/0pnLGf24cFVOtMyGN9OPvQMrmxN1jtm0MYIurnESNPTXZlju?=
 =?us-ascii?Q?ZP/MBoinYhX6hNfRFq2HkAgM5BuiUz4aYQB543cYONaR?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDE87D521D42AB49AF5CCA71A6B06C8A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8108.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a03f50e-3b36-4201-91ec-08ddfb8fef15
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 17:29:36.6455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZzLNZ5vpf1xOm7OthjfUIdGqi5/uv+wAQCzZzn2bqv60DCLZOEDAuo8h38gpZ4bCPDOES1mkEwgBS6y7awiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8358
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: alln-l-core-01.cisco.com


> On Sep 21, 2025, at 20:56, Andrew Jeffery <andrew@codeconstruct.com.au> w=
rote:
>=20
> On Fri, 2025-09-19 at 14:53 -0500, Rob Herring (Arm) wrote:
>> Convert the ASpeed SDRAM EDAC binding to DT schema. It's a
>> straight-forward conversion.
>>=20
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>=20
> Thanks Rob.
>=20
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>


