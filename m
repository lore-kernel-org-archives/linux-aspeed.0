Return-Path: <linux-aspeed+bounces-2448-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B1ACCD18E
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 22:00:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmSnF4KPNz2xdg;
	Wed, 15 Oct 2025 09:00:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.181.50.185
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760407517;
	cv=none; b=WUh96qT6sr5WsmwuanH5aGJbeW7N7FoztDwmW5cUUcTWd9lER8T99+1mwxQFQ9gfFifgUFFCs4caru7V1+ApCzH/scLlRHo1MIGSx4M9nxJ8RKW5TePfUMovt1P2IB5j8KWYuauWdzYlzcsXwEqO0Bpa0seYUT3yZJkG0jXZDH+ovNUMiflNNtwq3dOyJmuuFt+ITsrBtEpyx2vlwqb55KROq9f4jx5BIJ4j3JKmEd5cZcVlrTAcrRm6NNvh4jWQwgLhh2CpfxsjOuifhUNzwJju4yXUZQQ8opP7YJapfQvuaZH8fX74B3Q9I3/uD0uM5WhwMoBT1T9v3Z6lRy2//g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760407517; c=relaxed/relaxed;
	bh=88pRAd+vCrxh6D63c2WI4iArk5SiqA0nDyoYHVTguO0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F3dI7WX1FXbG06JZcdEbuzbZ/xy6pC4/N74iMrfmEoJmvqS/nvEXErwXUes2K46/t7WMGOnqHlTHtVQlA4C17HFhlIU4sjYnqbYVfJe9M5q6lAxaEhpUHMBbllfRU3kJir0tLU2vNmGooDlgeUqir5VoBoKUgLSaUqs+0SSi8AxAAdBFtUrRvBdWnvHvSDclUo+o58pLWG7GFV1NA85TrCWCprTZIs8MQm0+3dfncdMf5BFMn46MPXlPqHthIlkgVD8hj3YgJrJABSSW2Y5ZjKSIut334gP7bpvZ0c6MvWYUYW1O8qGdGyuxvgu96LrNhAuYXN9jF2mRstlR2/Lw2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass (client-ip=220.181.50.185; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org) smtp.mailfrom=baidu.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baidu.com (client-ip=220.181.50.185; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 136535 seconds by postgrey-1.37 at boromir; Tue, 14 Oct 2025 13:05:16 AEDT
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4clyGh0f3Cz2xQ0
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 13:05:14 +1100 (AEDT)
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Andrew Morton
	<akpm@linux-foundation.org>, Lance Yang <lance.yang@linux.dev>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>,
	"Petr Mladek" <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Feng
 Tang <feng.tang@linux.alibaba.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Kees Cook <kees@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Phil Auld <pauld@redhat.com>, Joel Granados
	<joel.granados@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand
	<david@redhat.com>, Florian Westphal <fw@strlen.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "wireguard@lists.zx2c4.com"
	<wireguard@lists.zx2c4.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdW3YzXSBodW5nX3Rhc2s6?=
 =?utf-8?Q?_Panic_after_fixed_number_of_hung_tasks?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bdjNdIGh1bmdfdGFzazogUGFu?=
 =?utf-8?Q?ic_after_fixed_number_of_hung_tasks?=
Thread-Index: AQHcO26DBhE8v5YbxE+aupLwXa3Lo7TAWTwAgACNKWA=
Date: Tue, 14 Oct 2025 02:03:19 +0000
Message-ID: <61a45c98b3a14b75bb83a2a5ea4dab51@baidu.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <b16d76de-688a-4697-bcfe-06f2785a1d3c@infradead.org>
In-Reply-To: <b16d76de-688a-4697-bcfe-06f2785a1d3c@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.127.72.30]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

DQoNCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFy
YW1ldGVycy50eHQNCj4gYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0
ZXJzLnR4dA0KPiA+IGluZGV4IGE1MWFiNDYuLjdkOWE4ZWUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiA+IEBAIC0x
OTkyLDE0ICsxOTkyLDIwIEBADQo+ID4gIAkJCXRoZSBhZGRlZCBtZW1vcnkgYmxvY2sgaXRzZWxm
IGRvIG5vdCBiZSBhZmZlY3RlZC4NCj4gPg0KPiA+ICAJaHVuZ190YXNrX3BhbmljPQ0KPiA+IC0J
CQlbS05MXSBTaG91bGQgdGhlIGh1bmcgdGFzayBkZXRlY3RvciBnZW5lcmF0ZSBwYW5pY3MuDQo+
ID4gLQkJCUZvcm1hdDogMCB8IDENCj4gPiArCQkJW0tOTF0gTnVtYmVyIG9mIGh1bmcgdGFza3Mg
dG8gdHJpZ2dlciBrZXJuZWwgcGFuaWMuDQo+ID4gKwkJCUZvcm1hdDogPGludD4NCj4gPiArDQo+
ID4gKwkJCVNldCB0aGlzIHRvIHRoZSBudW1iZXIgb2YgaHVuZyB0YXNrcyB0aGF0IG11c3QgYmUN
Cj4gPiArCQkJZGV0ZWN0ZWQgYmVmb3JlIHRyaWdnZXJpbmcgYSBrZXJuZWwgcGFuaWMuDQo+ID4g
Kw0KPiA+ICsJCQkwOiBkb24ndCBwYW5pYw0KPiA+ICsJCQkxOiBwYW5pYyBpbW1lZGlhdGVseSBv
biBmaXJzdCBodW5nIHRhc2sNCj4gPiArCQkJTjogcGFuaWMgYWZ0ZXIgTiBodW5nIHRhc2tzIGFy
ZSBkZXRlY3QNCj4gDQo+IAkJCSAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcmUgZGV0ZWN0
ZWQNCj4gDQoNClRoYW5rcywgd2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9uDQoNCi1MaQ0KDQoNCg==

