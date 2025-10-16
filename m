Return-Path: <linux-aspeed+bounces-2477-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959A2CCD183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Oct 2025 22:33:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnjRF4G1xz3cYH;
	Fri, 17 Oct 2025 09:33:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=111.206.215.185
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760594380;
	cv=none; b=FCWTtjmHHyCj1h2GhSzSswK/l77eyu4neWmZLKaah5O7t/YgnM3Jz17MraPlRwlTXh52ZYf7NBqoGa3YzvYkT5faWF8iSt76Z2QiBhq0cYG0TexjYHN4nsEkyLkCAGynaxs3FFKpJL0vzL8euIseHUcvX6p8gv6Juoo8Yel4NQ8Vg/zrE26H4GhnjogbF5W9JMZuXRvz+aqouhCy5gKJwocx69mLuOcTCbq1Um3FXbfp5yctCVL5DYjRqsnnwFObU40UDgtVxsQV4xBq7/Yt7HXZWUvaw32AkncUlyNcR25VO9lNXcjxoa0rghhpCq8msqmOYhTzGOv7jxdsr3IuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760594380; c=relaxed/relaxed;
	bh=zL3WvO3665EouwcoDa/nbIqn/ahEBMnS/1uR2CNyfWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YEbr5cz3cudff/gUUZn4Jp9Poc28FXz3ywuyKtMU74K5ZuTEOuNIwRPdmzA3vPHiHOpjmjXCQWyLbS3ut93Qn3ZHwBcyCBr1/044I+jwDWoIV48eipcT1XvDzT4pV2NUKiGUFEeSiksFRHefY5zRD7igU8J1UAUg9uqBJVV6lwDKzcM/0AsvT2c55Qn1DOa/dKECJmcxxP3StwCNIYlGfMSRfiRswONbw3xoHUQawQnUYU5Qx1YnHFErIsgn6eAZWLgQreAiYh8EDqjb7z9/d7cV3z5ZLxBS+rtMC07UsjowG15HW9w69mECX5BmFqgvK4kf7rBtaeBS70Et8DfRqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass (client-ip=111.206.215.185; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org) smtp.mailfrom=baidu.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baidu.com (client-ip=111.206.215.185; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnHNC42KGz2ywC
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 16:59:36 +1100 (AEDT)
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Lance Yang <lance.yang@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "wireguard@lists.zx2c4.com"
	<wireguard@lists.zx2c4.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Hildenbrand
	<david@redhat.com>, Florian Wesphal <fw@strlen.de>, Jakub Kacinski
	<kuba@kernel.org>, "Jason A . Donenfeld" <jason@zx2c4.com>, Joel Granados
	<joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Liam Howlett
	<liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Petr Mladek <pmladek@suse.com>, "Phil
 Auld" <pauld@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Russell King
	<linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt
	<rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdW3Y0XSBodW5nX3Rhc2s6?=
 =?utf-8?B?IFBhbmljIHdoZW4gdGhlcmUgYXJlIG1vcmUgdGhhbiBOIGh1bmcgdGFza3Mg?=
 =?utf-8?Q?at_the_same_time?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bdjRdIGh1bmdfdGFzazogUGFu?=
 =?utf-8?B?aWMgd2hlbiB0aGVyZSBhcmUgbW9yZSB0aGFuIE4gaHVuZyB0YXNrcyBhdCB0?=
 =?utf-8?Q?he_same_time?=
Thread-Index: AQHcPZ4O/k3Wsx0bHk6g9O8K49+CJbTDtCqAgACThiA=
Date: Thu, 16 Oct 2025 05:57:34 +0000
Message-ID: <bb443552b6db40548a4fae98d1f63c80@baidu.com>
References: <20251015063615.2632-1-lirongqing@baidu.com>
 <4db3bd26-1f74-4096-84fd-f652ec9a4d27@linux.dev>
In-Reply-To: <4db3bd26-1f74-4096-84fd-f652ec9a4d27@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.127.72.23]
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

DQo+IExHVE0uIEl0IHdvcmtzIGFzIGV4cGVjdGVkLCB0aGFua3MhDQo+IA0KPiBPbiAyMDI1LzEw
LzE1IDE0OjM2LCBsaXJvbmdxaW5nIHdyb3RlOg0KPiA+IEZyb206IExpIFJvbmdRaW5nIDxsaXJv
bmdxaW5nQGJhaWR1LmNvbT4NCj4gDQo+IEZvciB0aGUgY29tbWl0IG1lc3NhZ2UsIEknZCBzdWdn
ZXN0IHRoZSBmb2xsb3dpbmcgZm9yIGJldHRlciBjbGFyaXR5Og0KPiANCj4gYGBgDQo+IFRoZSBo
dW5nX3Rhc2tfcGFuaWMgc3lzY3RsIGlzIGN1cnJlbnRseSBhIGJsdW50IGluc3RydW1lbnQ6IGl0
J3MgYWxsIG9yIG5vdGhpbmcuDQo+IA0KPiBQYW5pY2tpbmcgb24gYSBzaW5nbGUgaHVuZyB0YXNr
IGNhbiBiZSBhbiBvdmVycmVhY3Rpb24gdG8gYSB0cmFuc2llbnQgZ2xpdGNoLiBBDQo+IG1vcmUg
cmVsaWFibGUgaW5kaWNhdG9yIG9mIGEgc3lzdGVtaWMgcHJvYmxlbSBpcyB3aGVuIG11bHRpcGxl
IHRhc2tzIGhhbmcNCj4gc2ltdWx0YW5lb3VzbHkuDQo+IA0KPiBFeHRlbmQgaHVuZ190YXNrX3Bh
bmljIHRvIGFjY2VwdCBhbiBpbnRlZ2VyIHRocmVzaG9sZCwgYWxsb3dpbmcgdGhlIGtlcm5lbA0K
PiB0byBwYW5pYyBvbmx5IHdoZW4gTiBodW5nIHRhc2tzIGFyZSBkZXRlY3RlZCBpbiBhIHNpbmds
ZSBzY2FuLiBUaGlzIHByb3ZpZGVzDQo+IGZpbmVyIGNvbnRyb2wgdG8gZGlzdGluZ3Vpc2ggYmV0
d2VlbiBpc29sYXRlZCBpbmNpZGVudHMgYW5kIHN5c3RlbS13aWRlDQo+IGZhaWx1cmVzLg0KPiAN
Cj4gVGhlIGFjY2VwdGVkIHZhbHVlcyBhcmU6DQo+IC0gMDogRG9uJ3QgcGFuaWMgKHVuY2hhbmdl
ZCkNCj4gLSAxOiBQYW5pYyBvbiB0aGUgZmlyc3QgaHVuZyB0YXNrICh1bmNoYW5nZWQpDQo+IC0g
TiA+IDE6IFBhbmljIGFmdGVyIE4gaHVuZyB0YXNrcyBhcmUgZGV0ZWN0ZWQgaW4gYSBzaW5nbGUg
c2Nhbg0KPiANCj4gVGhlIG9yaWdpbmFsIGJlaGF2aW9yIGlzIHByZXNlcnZlZCBmb3IgdmFsdWVz
IDAgYW5kIDEsIG1haW50YWluaW5nIGZ1bGwNCj4gYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCj4g
YGBgDQo+IA0KPiBJZiB5b3UgYWdyZWUsIGxpa2VseSBubyBuZWVkIHRvIHJlc2VuZCAtIEFuZHJl
dyBjb3VsZCBwaWNrIGl0IHVwIGRpcmVjdGx5IHdoZW4NCj4gYXBwbHlpbmcgOikNCj4gDQoNClRo
aXMgaXMgYmV0dGVyOw0KDQpBbmRyZXcsIGNvdWxkIHlvdSBwaWNrIGl0IHVwIGRpcmVjdGx5DQoN
ClRoYW5rcw0KDQotTGkNCg0KPiA+DQo+ID4gQ3VycmVudGx5LCB3aGVuICdodW5nX3Rhc2tfcGFu
aWMnIGlzIGVuYWJsZWQsIHRoZSBrZXJuZWwgcGFuaWNzDQo+ID4gaW1tZWRpYXRlbHkgdXBvbiBk
ZXRlY3RpbmcgdGhlIGZpcnN0IGh1bmcgdGFzay4gSG93ZXZlciwgc29tZSBodW5nDQo+ID4gdGFz
a3MgYXJlIHRyYW5zaWVudCBhbmQgYWxsb3cgc3lzdGVtIHJlY292ZXJ5LCB3aGlsZSBwZXJzaXN0
ZW50IGhhbmdzDQo+ID4gc2hvdWxkIHRyaWdnZXIgYSBwYW5pYyB3aGVuIGFjY3VtdWxhdGluZyBi
ZXlvbmQgYSB0aHJlc2hvbGQuDQo+ID4NCj4gPiBFeHRlbmQgdGhlICdodW5nX3Rhc2tfcGFuaWMn
IHN5c2N0bCB0byBhY2NlcHQgYSB0aHJlc2hvbGQgdmFsdWUNCj4gPiBzcGVjaWZ5aW5nIHRoZSBu
dW1iZXIgb2YgaHVuZyB0YXNrcyB0aGF0IG11c3QgYmUgZGV0ZWN0ZWQgYmVmb3JlDQo+ID4gdHJp
Z2dlcmluZyBhIGtlcm5lbCBwYW5pYy4gVGhpcyBwcm92aWRlcyBmaW5lciBjb250cm9sIGZvcg0K
PiA+IGVudmlyb25tZW50cyB3aGVyZSB0cmFuc2llbnQgaGFuZ3MgbWF5IG9jY3VyIGJ1dCBwZXJz
aXN0ZW50IGhhbmdzDQo+IHNob3VsZCBiZSBmYXRhbC4NCj4gPg0KPiA+IFRoZSBzeXNjdGwgbm93
IGFjY2VwdHM6DQo+ID4gLSAwOiBkb24ndCBwYW5pYyAobWFpbnRhaW5zIG9yaWdpbmFsIGJlaGF2
aW9yKQ0KPiA+IC0gMTogcGFuaWMgb24gZmlyc3QgaHVuZyB0YXNrIChtYWludGFpbnMgb3JpZ2lu
YWwgYmVoYXZpb3IpDQo+ID4gLSBOID4gMTogcGFuaWMgYWZ0ZXIgTiBodW5nIHRhc2tzIGFyZSBk
ZXRlY3RlZCBpbiBhIHNpbmdsZSBzY2FuDQo+ID4NCj4gPiBUaGlzIG1haW50YWlucyBiYWNrd2Fy
ZCBjb21wYXRpYmlsaXR5IHdoaWxlIHByb3ZpZGluZyBmbGV4aWJpbGl0eSBmb3INCj4gPiBkaWZm
ZXJlbnQgaGFuZyBzY2VuYXJpb3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBSb25nUWlu
ZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gQ2M6IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdA
Y29kZWNvbnN0cnVjdC5jb20uYXU+DQo+ID4gQ2M6IEFuc2h1bWFuIEtoYW5kdWFsIDxhbnNodW1h
bi5raGFuZHVhbEBhcm0uY29tPg0KPiA+IENjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRl
Pg0KPiA+IENjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gPiBDYzog
RmxvcmlhbiBXZXNwaGFsIDxmd0BzdHJsZW4uZGU+DQo+ID4gQ2M6IEpha3ViIEthY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IEphc29uIEEuIERvbmVuZmVsZCA8amFzb25AengyYzQu
Y29tPg0KPiA+IENjOiBKb2VsIEdyYW5hZG9zIDxqb2VsLmdyYW5hZG9zQGtlcm5lbC5vcmc+DQo+
ID4gQ2M6IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+DQo+ID4gQ2M6IEpvbmF0aGFuIENv
cmJldCA8Y29yYmV0QGx3bi5uZXQ+DQo+ID4gQ2M6IEtlZXMgQ29vayA8a2Vlc0BrZXJuZWwub3Jn
Pg0KPiA+IENjOiBMYW5jZSBZYW5nIDxsYW5jZS55YW5nQGxpbnV4LmRldj4NCj4gPiBDYzogTGlh
bSBIb3dsZXR0IDxsaWFtLmhvd2xldHRAb3JhY2xlLmNvbT4NCj4gPiBDYzogTG9yZW56byBTdG9h
a2VzIDxsb3JlbnpvLnN0b2FrZXNAb3JhY2xlLmNvbT4NCj4gPiBDYzogIk1hc2FtaSBIaXJhbWF0
c3UgKEdvb2dsZSkiIDxtaGlyYW1hdEBrZXJuZWwub3JnPg0KPiA+IENjOiAiUGF1bCBFIC4gTWNL
ZW5uZXkiIDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFBhd2FuIEd1cHRhIDxwYXdhbi5r
dW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IFBldHIgTWxhZGVrIDxwbWxhZGVr
QHN1c2UuY29tPg0KPiA+IENjOiBQaGlsIEF1bGQgPHBhdWxkQHJlZGhhdC5jb20+DQo+ID4gQ2M6
IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiA+IENjOiBSdXNzZWxsIEtp
bmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCj4gPiBDYzogU2h1YWggS2hhbiA8c2h1YWhAa2Vy
bmVsLm9yZz4NCj4gPiBDYzogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiA+IENj
OiBTdGFuaXNsYXYgRm9taWNoZXYgPHNkZkBmb21pY2hldi5tZT4NCj4gPiBDYzogU3RldmVuIFJv
c3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+ID4gLS0tDQo+IA0KPiBTbzoNCj4gDQo+IFJl
dmlld2VkLWJ5OiBMYW5jZSBZYW5nIDxsYW5jZS55YW5nQGxpbnV4LmRldj4NCj4gVGVzdGVkLWJ5
OiBMYW5jZSBZYW5nIDxsYW5jZS55YW5nQGxpbnV4LmRldj4NCj4gDQo+IENoZWVycywNCj4gTGFu
Y2UNCg0K

